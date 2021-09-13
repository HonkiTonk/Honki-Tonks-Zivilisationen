pragma SPARK_Mode (On);

with GlobaleTexte;

with SchreibeStadtGebaut, SchreibeWichtiges;
with LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseStadtGebaut;

with Anzeige, StadtWerteFestlegen, Eingabe, StadtProduktion, EinheitenAllgemein, Sichtbarkeit;

package body StadtBauen is

   function StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin     
        
      case
        StadtBaubar (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;

      StadtNummer := StadtnummerErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      case
        StadtNummer
      is
         when GlobaleDatentypen.MaximaleStädteMitNullWert'First =>
            return False;
            
         when others =>
            null;
      end case;
            
      StadtEintragen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                      PositionExtern         => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));            
      EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when GlobaleDatentypen.Spieler_KI =>
            StandardStadtNamen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
                  
         when others =>
            SchreibeStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                      NameExtern             => Eingabe.StadtName);
      end case;
      
      return True;
      
   end StadtBauen;
   
   
   
   function StadtBaubar
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Arbeiter =>
            null;
         
         when others =>
            return False;
      end case;
      
      if
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
      then
         return True;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return False;
         
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 6);
         return False;
      end if;
      
   end StadtBaubar;
   
   
   
   function StadtnummerErmitteln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           StadtNummerSchleifenwert = GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
           and
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= GlobaleDatentypen.Leer
         then
            case
              GlobaleVariablen.RassenImSpiel (RasseExtern)
            is
               when GlobaleDatentypen.Spieler_Mensch =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                        TextZeileExtern => 7);
               
               when others =>
                  null;
            end case;

         elsif
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= GlobaleDatentypen.Leer
         then
            null;
            
         else
            return StadtNummerSchleifenwert;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleDatentypen.MaximaleStädteMitNullWert'First;
      
   end StadtnummerErmitteln;
   
   
   
   procedure StadtEintragen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => HauptstadtPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse));
      SchreibeStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                    PositionExtern         => PositionExtern);
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           UmgebungGrößeExtern    => 1,
                                           ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             ÄnderungExtern         => 1);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             ÄnderungExtern         => 1);
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung := (0 => (0 => True, others => False), others => (others => False));
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => True);
      
      StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => StadtRasseNummerExtern.Rasse);
      Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtEintragen;



   function HauptstadtPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, HauptstadtSchleifenwert))
         is
            when GlobaleDatentypen.Eigene_Hauptstadt =>
               return GlobaleDatentypen.Eigene_Stadt;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return GlobaleDatentypen.Eigene_Hauptstadt;
      
   end HauptstadtPrüfen;
   
   
   
   procedure StandardStadtNamen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                NameExtern             => GlobaleTexte.TexteEinlesenNeu (22, WelcherName));
      
      case
        WelcherName
      is
         when 3 =>
            WelcherName := 1;
            
         when others =>
            WelcherName := WelcherName + 1;
      end case;
      
   end StandardStadtNamen;

end StadtBauen;
