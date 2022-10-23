pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with MausauswahlLogik;
with KartenberechnungenGrafik;
with StadtproduktionLogik;

package body EinwohnersystemLogik is

   function EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      Mausposition := MausauswahlLogik.Stadtumgebung;
      
      if
        Mausposition.x < 0.00
      then
         return False;
               
      else
         Stadtfeld.YAchse := KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / KartenberechnungenGrafik.StadtfelderAbmessung.y)) - 3;
         Stadtfeld.XAchse := KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / KartenberechnungenGrafik.StadtfelderAbmessung.x)) - 3;
      end if;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Stadtfeld.YAchse, Stadtfeld.XAchse),
                                                                                                LogikGrafikExtern => True);
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            EinwohnerBelegungÄndern (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      YAchseExtern           => Stadtfeld.YAchse,
                                      XAchseExtern           => Stadtfeld.XAchse);
            return True;
      end case;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YKoordinateExtern      => YAchseExtern,
                                                 XKoordinateExtern      => XAchseExtern)
      is
         when True =>
            EinwohnerEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                YAchseExtern           => YAchseExtern,
                                XAchseExtern           => XAchseExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               YAchseExtern           => YAchseExtern,
                               XAchseExtern           => XAchseExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   YKoordinateExtern      => YAchseExtern,
                                                   XKoordinateExtern      => XAchseExtern,
                                                   BelegenEntfernenExtern => False);
      
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             WachsenSchrumpfenExtern => False);
      
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                           EinwohnerArbeiterExtern => False)
        < LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        and
          True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                          KoordinatenExtern      => Kartenwert)
      then
         SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      YKoordinateExtern      => YAchseExtern,
                                                      XKoordinateExtern      => XAchseExtern,
                                                      BelegenEntfernenExtern => True);
         
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => False,
                                                WachsenSchrumpfenExtern => True);
         
         StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnersystemLogik;
