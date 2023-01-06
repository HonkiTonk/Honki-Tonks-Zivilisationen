with KartenDatentypen;
with Rassentexte;
with TextnummernKonstanten;

with SchreibeStadtGebaut;
with SchreibeWichtiges;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with SchreibeWeltkarte;

with StadtumgebungFestlegenLogik;
with TexteingabeLogik;
with StadtproduktionLogik;
with SichtbarkeitsberechnungssystemLogik;
with EinheitenErzeugenEntfernenLogik;
with Fehlermeldungssystem;
with WegeplatzierungssystemLogik;
with EinheitenSpielmeldungenLogik;
with MeldungFestlegenLogik;

package body StadtBauenLogik is

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
        LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            StadtName.EingegebenerText := Rassentexte.Städtenamen (EinheitRasseNummerExtern.Rasse, StadtNummer);
                  
         when RassenDatentypen.Mensch_Spieler_Enum =>
            StadtName := TexteingabeLogik.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer),
                                                     BauenExtern            => True);
            
            if
              StadtName.ErfolgreichAbbruch = False
            then
               return False;
               
            else
               null;
            end if;
            
         when RassenDatentypen.Leer_Spieler_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "StadtBauen.StadtBauen: Nicht vorhandene Rasse baut Stadt.");
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
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      case
        EinheitenSpielmeldungenLogik.ArbeiteraufgabeMeldung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when False =>
            return False;
         
         when True =>
            Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      if
        EinheitRasseNummerExtern.Rasse = RassenDatentypen.Ekropa_Enum
        and
          Einheitenkoordinaten.EAchse /= 0
      then
         return False;
         
      else
         null;
      end if;
                  
      if
        LeseWeltkarte.UnbelegterGrund (KoordinatenExtern => Einheitenkoordinaten) = True
      then
         return True;
         
      elsif
        LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
      then
         return False;
         
      else
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBelegt);
         return False;
      end if;
      
   end StadtBaubar;
   
   
   
   function StadtnummerErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
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
        LeseRassenbelegung.Belegung (RasseExtern => RasseExtern)
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
      
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => True);
      
      Stadtart := HauptstadtPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      SchreibeStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => Stadtart);
      SchreibeStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                       KoordinatenExtern      => KoordinatenExtern);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             WachsenSchrumpfenExtern => True);
      
      WegAnlegen (KoordinatenExtern => KoordinatenExtern);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => Stadtart);
      
      SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                       BelegterGrundExtern => StadtRasseNummerExtern);
      
      -- StadtwerteFestlegenLogik/Stadtproduktion muss immer nach Änderungen an Verbesserungen/Wege berechnet werden, sonst werden diese Änderungen ja nicht berücksichtigt.
      StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => StadtRasseNummerExtern.Rasse);
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtEintragen;
   
   
   
   -- Später auch eine Schiene anlegen? äöü
   procedure WegAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenDatentypen.EbeneLuft'Range =>
            return;
            
         when KartenKonstanten.OberflächeKonstante =>
            WelcherWeg := AufgabenDatentypen.Straße_Bauen_Enum;
            
         when others =>
            WelcherWeg := AufgabenDatentypen.Tunnel_Bauen_Enum;
      end case;
      
      WegeplatzierungssystemLogik.Wegplatzierung (KoordinatenExtern => KoordinatenExtern,
                                                  WegartExtern      => WelcherWeg);
            
   end WegAnlegen;
   


   function HauptstadtPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
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
   
end StadtBauenLogik;
