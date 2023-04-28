with KartenDatentypen;
with Speziestexte;
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
        
      case
        StadtBaubar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when True =>
            StadtNummer := StadtnummerErmitteln (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
            
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
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            StadtName.EingegebenerText := Speziestexte.Städtenamen (EinheitSpeziesNummerExtern.Spezies, StadtNummer);
                  
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            StadtName := TexteingabeLogik.StadtName (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummer),
                                                     BauenExtern              => True);
            
            if
              StadtName.ErfolgreichAbbruch = False
            then
               return False;
               
            else
               null;
            end if;
            
         when SpeziesDatentypen.Leer_Spieler_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "StadtBauenLogik.StadtBauen: Nicht vorhandene Spezies baut Stadt");
            return False;
      end case;
            
      -- Immer daran denken dass die Stadt bei StadtEintragen auf Leer gesetzt wird und deswegen der Name danach eingetragen werden muss.
      StadtEintragen (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummer),
                      KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      SchreibeStadtGebaut.Name (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, StadtNummer),
                                NameExtern               => StadtName.EingegebenerText);
      EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      return True;
      
   end StadtBauen;
   
   
   
   function StadtBaubar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      case
        EinheitenSpielmeldungenLogik.ArbeiteraufgabeMeldung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when False =>
            return False;
         
         when True =>
            Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      if
        EinheitSpeziesNummerExtern.Spezies = SpeziesDatentypen.Ekropa_Enum
        and
          Einheitenkoordinaten.EAchse /= KartenKonstanten.LeerEAchseÄnderung
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
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
      then
         return False;
         
      else
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBelegt);
         return False;
      end if;
      
   end StadtBaubar;
   
   
   
   function StadtnummerErmitteln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummerSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               return StadtNummerSchleifenwert;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungStädtemaximum);
            
         when others =>
            null;
      end case;
      
      return StadtDatentypen.MaximaleStädteMitNullWert'First;
      
   end StadtnummerErmitteln;
   
   
   
   procedure StadtEintragen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeStadtGebaut.Nullsetzung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SchreibeWichtiges.AnzahlStädte (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                       PlusMinusExtern => True);
      
      Stadtart := HauptstadtPrüfen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      SchreibeStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                              IDExtern                 => Stadtart);
      SchreibeStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       KoordinatenExtern        => KoordinatenExtern);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern  => True,
                                             WachsenSchrumpfenExtern  => True);
      
      WegAnlegen (KoordinatenExtern => KoordinatenExtern);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => Stadtart);
      
      SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                       BelegterGrundExtern => StadtSpeziesNummerExtern);
      
      -- StadtwerteFestlegenLogik/Stadtproduktion muss immer nach Änderungen an Verbesserungen/Wege berechnet werden, sonst werden diese Änderungen ja nicht berücksichtigt.
      StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      SchreibeWichtiges.VerbleibendeForschungszeit (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürStadt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenverbesserungDatentypen.Verbesserung_Städte_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, HauptstadtSchleifenwert))
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
