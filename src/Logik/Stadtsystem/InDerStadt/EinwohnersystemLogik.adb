with Sf.Graphics.View;

with ProduktionDatentypen;
with KartenKonstanten;
with GrafikKonstanten;
with Views;
with ViewKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with MausauswahlLogik;
with StadtproduktionLogik;

-- with Diagnoseinformationen;

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
         Test.x := Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).x / GrafikKonstanten.AnzahlStadtumgebungsfelder;
         Test.y := Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).y / GrafikKonstanten.AnzahlStadtumgebungsfelder;
         Stadtfeld := (-4, -4);
         
         
         YAchseSchleife:
         for YAchseSchleifenwert in 0 .. Positive (GrafikKonstanten.AnzahlStadtumgebungsfelder) - 1 loop
            
            if
              Mausposition.y in Float (YAchseSchleifenwert) * Test.y .. Float (YAchseSchleifenwert + 1) * Test.y
            then
               Stadtfeld.YAchse := KartenDatentypen.Kartenfeld (YAchseSchleifenwert) - 3;
               exit YAchseSchleife;
               
            else
               null;
            end if;
               
         end loop YAchseSchleife;
         
         XAchseSchleife:
         for XAchseSchleifenwert in 0 .. Positive (GrafikKonstanten.AnzahlStadtumgebungsfelder) - 1 loop
            
            if
              Mausposition.y in Float (XAchseSchleifenwert) * Test.x .. Float (XAchseSchleifenwert + 1) * Test.x
            then
               Stadtfeld.XAchse := KartenDatentypen.Kartenfeld (XAchseSchleifenwert) - 3;
               exit XAchseSchleife;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end if;
      
      if
        Stadtfeld.YAchse = -4
        or
          Stadtfeld.YAchse = -4
      then
         return False;
            
      else
         Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                                                   ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Stadtfeld.YAchse, Stadtfeld.XAchse),
                                                                                                   LogikGrafikExtern => True);
      end if;
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            EinwohnerBelegungÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      YAchseExtern             => Stadtfeld.YAchse,
                                      XAchseExtern             => Stadtfeld.XAchse);
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
                                                 YKoordinateExtern        => YAchseExtern,
                                                 XKoordinateExtern        => XAchseExtern)
      is
         when True =>
            EinwohnerEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                YAchseExtern             => YAchseExtern,
                                XAchseExtern             => XAchseExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               YAchseExtern             => YAchseExtern,
                               XAchseExtern             => XAchseExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   YKoordinateExtern        => YAchseExtern,
                                                   XKoordinateExtern        => XAchseExtern,
                                                   BelegenEntfernenExtern   => False);
      
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern  => False,
                                             WachsenSchrumpfenExtern  => False);
      
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
        LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                           EinwohnerArbeiterExtern  => False)
        < LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern  => True)
        and
          True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                          KoordinatenExtern        => Kartenwert)
      then
         SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      YKoordinateExtern        => YAchseExtern,
                                                      XKoordinateExtern        => XAchseExtern,
                                                      BelegenEntfernenExtern   => True);
         
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                EinwohnerArbeiterExtern  => False,
                                                WachsenSchrumpfenExtern  => True);
         
         StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         
      else
         null;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnersystemLogik;
