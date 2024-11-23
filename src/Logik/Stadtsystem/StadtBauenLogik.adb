with KartenDatentypen;
with Speziestexte;
with TextnummernKonstanten;
with KartengrundDatentypen;

with SchreibeStadtGebaut;
with SchreibeWichtiges;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with SchreibeWeltkarte;
with LeseForschungenDatenbank;

with StadtumgebungFestlegenLogik;
with TexteingabeLogik;
with StadtproduktionLogik;
with SichtbarkeitsberechnungssystemLogik;
with EinheitenErzeugenEntfernenLogik;
with MeldungssystemHTB1;
with WegeplatzierungssystemLogik;
with EinheitenSpielmeldungenLogik;
with MeldungFestlegenLogik;
with ForschungstestsLogik;

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
         when StadtDatentypen.Städtebereich'First =>
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
            MeldungssystemHTB1.Logik (MeldungExtern => "StadtBauenLogik.StadtBauen: Nicht vorhandene Spezies baut Stadt");
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
          Einheitenkoordinaten.Ebene /= KartenKonstanten.LeerEbeneÄnderung
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return StadtDatentypen.Städtebereich
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummerSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
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
      
      return StadtDatentypen.Städtebereich'First;
      
   end StadtnummerErmitteln;
   
   
   
   procedure StadtEintragen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
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
      
      WegAnlegen (KoordinatenExtern => KoordinatenExtern,
                  SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
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
   
   
   
   procedure WegAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)
      is
         when KartengrundDatentypen.Vernichtet_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenDatentypen.EbeneLuft'Range =>
            return;
            
         when KartenKonstanten.OberflächeKonstante =>
            -- Das hier mal auslagern und auch in WegErmittelnLogik anpassen/zusammenführen/sinnvoller gestalten. äöü
            if
              True = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                TechnologieExtern => LeseForschungenDatenbank.Wege (WegExtern     => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                                                                                    SpeziesExtern => SpeziesExtern))
            then
               WelcherWeg := AufgabenDatentypen.Schiene_Bauen_Enum;
               
            else
               WelcherWeg := AufgabenDatentypen.Straße_Bauen_Enum;
            end if;
            
         when others =>
            WelcherWeg := AufgabenDatentypen.Tunnel_Bauen_Enum;
      end case;
      
      WegeplatzierungssystemLogik.Wegplatzierung (KoordinatenExtern => KoordinatenExtern,
                                                  WegartExtern      => WelcherWeg);
            
   end WegAnlegen;
   


   function HauptstadtPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenverbesserungDatentypen.Verbesserung_Städte_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, HauptstadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Hauptstadt_Enum =>
               return KartenverbesserungDatentypen.Stadt_Enum;
               
            when StadtKonstanten.LeerID =>
               exit HauptsstadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return KartenverbesserungDatentypen.Hauptstadt_Enum;
      
   end HauptstadtPrüfen;
   
end StadtBauenLogik;
