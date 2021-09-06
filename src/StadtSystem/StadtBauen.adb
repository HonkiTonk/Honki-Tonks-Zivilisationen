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
         null;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return False;
         
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 6);
         return False;
      end if;

      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           StadtNummerSchleifenwert = GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze
           and
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) /= GlobaleDatentypen.Leer
         then
            case
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
            is
               when GlobaleDatentypen.Spieler_KI =>
                  return False;
               
               when others =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                        TextZeileExtern => 7);
                  return False;
            end case;

         elsif
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) /= GlobaleDatentypen.Leer
         then
            null;
            
         else
            StadtNummer := StadtNummerSchleifenwert;
            exit StadtSchleife;
         end if;
         
      end loop StadtSchleife;
            
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      SchreibeStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                              IDExtern               => HauptstadtPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse));
      SchreibeStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                    PositionExtern         => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                           UmgebungGrößeExtern    => 1,
                                           ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                             EinwohnerArbeiterExtern => True,
                                             ÄnderungExtern         => 1);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                             EinwohnerArbeiterExtern => False,
                                             ÄnderungExtern         => 1);
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).UmgebungBewirtschaftung := (0 => (0 => True, others => False), others => (others => False));
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                       PlusMinusExtern => True);
      
      StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => EinheitRasseNummerExtern.Rasse);
      Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
            
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
