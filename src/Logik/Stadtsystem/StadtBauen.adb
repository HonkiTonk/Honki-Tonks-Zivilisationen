pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleTexte;

with SchreibeStadtGebaut;
with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with SchreibeKarten;

with StadtWerteFestlegen;
with Eingabe;
with StadtProduktion;
with Sichtbarkeit;
with EinheitenErzeugenEntfernen;
with Fehler;

package body StadtBauen is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
         when StadtDatentypen.MaximaleStädteMitNullWert'First =>
            return False;
            
         when others =>
            null;
      end case;
      
      -- Anpassen damit man bei Namen abbrechen kann. Eigenes System bauen um Städte ohne Namen zu ermöglichen oder einfach einen Namen ab sofort vorraussetzen?
      case
        SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            StadtName.EingegebenerText := StandardStadtNamen (RasseExtern => EinheitRasseNummerExtern.Rasse);
                  
         when RassenDatentypen.Mensch_Spieler_Enum =>
            StadtName := Eingabe.StadtName;
            
            if
              StadtName.ErfolgreichAbbruch = False
            then
               return False;
               
            else
               null;
            end if;
            
         when RassenDatentypen.Leer_Spieler_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "StadtBauen.StadtBauen - Eine nicht vorhandene Rasse baut eine Stadt.");
      end case;
            
      -- Immer daran denken dass die Stadt bei StadtEintragen auf Leer gesetzt wird und deswegen der Name danach eingetragen werden muss.
      StadtEintragen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                      KoordinatenExtern      => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      SchreibeStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                NameExtern             => StadtName.EingegebenerText);
      EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return True;
      
   end StadtBauen;
   
   
   
   function StadtBaubar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        EinheitRasseNummerExtern.Rasse = RassenDatentypen.Ekropa_Enum
        and
          LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse /= 0
      then
         return False;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            null;
         
         when others =>
            return False;
      end case;
      
      if
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
      then
         return True;
         
      elsif
        SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
      then
         return False;
         
      else
         -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
         --                                      TextZeileExtern => 6);
         return False;
      end if;
      
   end StadtBaubar;
   
   
   
   function StadtnummerErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           StadtNummerSchleifenwert = SpielVariablen.Grenzen (RasseExtern).Städtegrenze
           and
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
         then
            case
              SpielVariablen.RassenImSpiel (RasseExtern)
            is
               when RassenDatentypen.Mensch_Spieler_Enum =>
                  -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                  --                                       TextZeileExtern => 7);
                  null;
               
               when others =>
                  null;
            end case;

         elsif
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         else
            return StadtNummerSchleifenwert;
         end if;
         
      end loop StadtSchleife;
      
      return StadtDatentypen.MaximaleStädteMitNullWert'First;
      
   end StadtnummerErmitteln;
   
   
   
   procedure StadtEintragen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      --------------------------------------- Auch mal vollständig nach SchreibeStadt auslagern.
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Stadtart := HauptstadtPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      SchreibeStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => Stadtart);
      SchreibeStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                       KoordinatenExtern      => KoordinatenExtern);
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           UmgebungGrößeExtern    => 1,
                                           ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             WachsenSchrumpfenExtern => True);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             WachsenSchrumpfenExtern => True);
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungBewirtschaftung := (0 => (0 => True, others => False), others => (others => False));
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => True);
      
      StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => StadtRasseNummerExtern.Rasse);
      Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "StadtBauen.StadtEintragen - Keine Rasse baut eine Stadt.");
            
         when RassenDatentypen.Rassen_Überirdisch_Enum'Range =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Einzeln_Enum);
            
         when RassenDatentypen.Rassen_Erde_Enum'Range =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Tunnel_Einzeln_Enum);
            
         when RassenDatentypen.Rassen_Wasser_Enum'Range =>
            null;
      end case;
      
      SchreibeKarten.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                   VerbesserungExtern => Stadtart);
      
   end StadtEintragen;
   


   function HauptstadtPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Städte_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, HauptstadtSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Hauptstadt_Enum =>
               return KartenVerbesserungDatentypen.Stadt_Enum;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return KartenVerbesserungDatentypen.Hauptstadt_Enum;
      
   end HauptstadtPrüfen;
   
   
   
   function StandardStadtNamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      StadtName.EingegebenerText := GlobaleTexte.StädtenamenKI (RasseExtern, StadtnameVordefiniert (RasseExtern));
      
      case
        StadtnameVordefiniert (RasseExtern)
      is
         when GlobaleTexte.StädtenamenKI'Last (2) =>
            StadtnameVordefiniert (RasseExtern) := ZahlenDatentypen.EigenesPositive'First;
            
         when others =>
            StadtnameVordefiniert (RasseExtern) := StadtnameVordefiniert (RasseExtern) + 1;
      end case;
      
      return StadtName.EingegebenerText;
      
   end StandardStadtNamen;

end StadtBauen;
