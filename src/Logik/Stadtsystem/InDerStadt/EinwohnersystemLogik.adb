with ProduktionDatentypen;
with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with MausauswahlLogik;
with SichtweitenGrafik;
with StadtproduktionLogik;

package body EinwohnersystemLogik is

   function EinwohnerZuweisenEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Mausposition := MausauswahlLogik.Stadtumgebung;
      
      if
        Mausposition.x < 0.00
      then
         return False;
               
      else
         Stadtfeld.YAchse := KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / SichtweitenGrafik.KartenfelderAbmessung.y)) - 3;
         Stadtfeld.XAchse := KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / SichtweitenGrafik.KartenfelderAbmessung.x)) - 3;
      end if;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Stadtfeld.YAchse, Stadtfeld.XAchse),
                                                                                                LogikGrafikExtern => True);
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            EinwohnerBelegungÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      YAchseExtern           => Stadtfeld.YAchse,
                                      XAchseExtern           => Stadtfeld.XAchse);
            return True;
      end case;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerBelegungÄndern
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                 YKoordinateExtern      => YAchseExtern,
                                                 XKoordinateExtern      => XAchseExtern)
      is
         when True =>
            EinwohnerEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                YAchseExtern           => YAchseExtern,
                                XAchseExtern           => XAchseExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               YAchseExtern           => YAchseExtern,
                               XAchseExtern           => XAchseExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   YKoordinateExtern      => YAchseExtern,
                                                   XKoordinateExtern      => XAchseExtern,
                                                   BelegenEntfernenExtern => False);
      
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             WachsenSchrumpfenExtern => False);
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                           EinwohnerArbeiterExtern => False)
        < LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        and
          True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                          KoordinatenExtern      => Kartenwert)
      then
         SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      YKoordinateExtern      => YAchseExtern,
                                                      XKoordinateExtern      => XAchseExtern,
                                                      BelegenEntfernenExtern => True);
         
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                EinwohnerArbeiterExtern => False,
                                                WachsenSchrumpfenExtern => True);
         
         StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         
      else
         null;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnersystemLogik;
