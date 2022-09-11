pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with Rassentexte;
with TextnummernKonstanten;

with SchreibeStadtGebaut;
with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with SchreibeKarten;

with StadtWerteFestlegen;
with TexteingabeLogik;
with StadtproduktionLogik;
with Sichtbarkeit;
with EinheitenErzeugenEntfernenLogik;
with Fehler;
with WegeplatzierungssystemLogik;
with EinheitenSpielmeldungenLogik;
with MeldungFestlegenLogik;

package body StadtBauen is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
        
      case
        StadtBaubar (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            StadtNummer := StadtnummerErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
         when False =>
            return False;
      end case;
      
      case
        StadtNummer
      is
         when StadtDatentypen.MaximaleStädteMitNullWert'First =>
            return False;
            
         when others =>
            null;
      end case;
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            StadtName.EingegebenerText := Rassentexte.Städtenamen (EinheitRasseNummerExtern.Rasse, StadtNummer);
                  
         when RassenDatentypen.Mensch_Spieler_Enum =>
            StadtName := TexteingabeLogik.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
            
            if
              StadtName.ErfolgreichAbbruch = False
            then
               return False;
               
            else
               null;
            end if;
            
         when RassenDatentypen.Leer_Spieler_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "StadtBauen.StadtBauen - Nicht vorhandene Rasse baut Stadt.");
      end case;
            
      -- Immer daran denken dass die Stadt bei StadtEintragen auf Leer gesetzt wird und deswegen der Name danach eingetragen werden muss.
      StadtEintragen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                      KoordinatenExtern      => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      SchreibeStadtGebaut.Name (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                NameExtern             => StadtName.EingegebenerText);
      EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return True;
      
   end StadtBauen;
   
   
   
   function StadtBaubar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        EinheitenSpielmeldungenLogik.ArbeiteraufgabeMeldung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            null;
         
         when False =>
            return False;
      end case;
      
      if
        EinheitRasseNummerExtern.Rasse = RassenDatentypen.Ekropa_Enum
        and
          LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse /= 0
      then
         return False;
         
      else
         null;
      end if;
                  
      if
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
      then
         return True;
         
      elsif
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
      then
         return False;
         
      else
         -- Hier später eine Meldung einbauen. äöü
         return False;
      end if;
      
   end StadtBaubar;
   
   
   
   function StadtnummerErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               return StadtNummerSchleifenwert;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      case
        SpielVariablen.Rassenbelegung (RasseExtern).Belegung
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungStädtemaximum);
            
         when others =>
            null;
      end case;
      
      return StadtDatentypen.MaximaleStädteMitNullWert'First;
      
   end StadtnummerErmitteln;
   
   
   
   procedure StadtEintragen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      -- Auch mal vollständig nach SchreibeStadt auslagern? äöü
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
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => StadtRasseNummerExtern.Rasse);
      Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      WegAnlegen (KoordinatenExtern => KoordinatenExtern,
                  RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      SchreibeKarten.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                   VerbesserungExtern => Stadtart);
      
   end StadtEintragen;
   
   
   
   -- Diese Prüfung mal erweitern und auch an anderen Stellen dann verwenden? äöü
   procedure WegAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenDatentypen.EbeneLuft'Range =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        RasseExtern
      is
         when RassenDatentypen.Rassen_Überirdisch_Enum'Range =>
            WelcherWeg := AufgabenDatentypen.Straße_Bauen_Enum;
            
         when RassenDatentypen.Rassen_Erde_Enum'Range =>
            WelcherWeg := AufgabenDatentypen.Tunnel_Bauen_Enum;
            
         when others =>
            return;
      end case;
      
      WegeplatzierungssystemLogik.Wegplatzierung (KoordinatenExtern => KoordinatenExtern,
                                                  WegartExtern      => WelcherWeg);
            
   end WegAnlegen;
   


   function HauptstadtPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, HauptstadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Hauptstadt_Enum =>
               return KartenverbesserungDatentypen.Stadt_Enum;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return KartenverbesserungDatentypen.Hauptstadt_Enum;
      
   end HauptstadtPrüfen;
   
end StadtBauen;
