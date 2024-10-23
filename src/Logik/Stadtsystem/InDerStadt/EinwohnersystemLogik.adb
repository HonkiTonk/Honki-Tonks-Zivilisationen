with Sf.Graphics.View;

with StadtDatentypen;
with KartenKonstanten;
with GrafikKonstanten;
with Views;
with ViewKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with MausauswahlLogik;
with StadtproduktionLogik;

package body EinwohnersystemLogik is

   function EinwohnerZuweisenEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Mausposition := MausauswahlLogik.Stadtumgebung;
      
      if
        Mausposition.x < GrafikKonstanten.Nullwert
      then
         return False;
         
      else
         Feldfläche := Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung));
         Feldfläche.x := Feldfläche.x / GrafikKonstanten.AnzahlStadtumgebungsfelder;
         Feldfläche.y := Feldfläche.y / GrafikKonstanten.AnzahlStadtumgebungsfelder;
         Stadtfeld.Senkrechte := YMausfeldPrüfen (MausachseExtern   => Mausposition.y,
                                               BasiswertExtern   => Feldfläche.y,
                                               AnfangswertExtern => 0,
                                               EndwertExtern     => KartenDatentypen.Senkrechte (Positive (GrafikKonstanten.AnzahlStadtumgebungsfelder) - 1));
      end if;
      
      case
        Stadtfeld.Senkrechte
      is
         when KartenDatentypen.Senkrechte'First =>
            return False;
            
         when others =>
            Stadtfeld.Senkrechte := Stadtfeld.Senkrechte - YKoordinatenausgleich;
            Stadtfeld.Waagerechte := XMausfeldPrüfen (MausachseExtern   => Mausposition.x,
                                                  BasiswertExtern   => Feldfläche.x,
                                                  AnfangswertExtern => 0,
                                                  EndwertExtern     => KartenDatentypen.Waagerechte (Positive (GrafikKonstanten.AnzahlStadtumgebungsfelder) - 1));
      end case;
      
      case
        Stadtfeld.Waagerechte
      is
         when KartenDatentypen.Waagerechte'First =>
            return False;
            
         when others =>
            Stadtfeld.Waagerechte := Stadtfeld.Waagerechte - XKoordinatenausgleich;
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, Stadtfeld.Senkrechte, Stadtfeld.Waagerechte),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      end case;
      
      case
        Kartenwert.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return False;
            
         when others =>
            EinwohnerBelegungÄndern (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      SenkrechteExtern             => Stadtfeld.Senkrechte,
                                      WaagerechteExtern             => Stadtfeld.Waagerechte);
            return True;
      end case;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerBelegungÄndern
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
   is begin
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                 YKoordinateExtern        => SenkrechteExtern,
                                                 XKoordinateExtern        => WaagerechteExtern)
      is
         when True =>
            EinwohnerEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                SenkrechteExtern             => SenkrechteExtern,
                                WaagerechteExtern             => WaagerechteExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                               SenkrechteExtern             => SenkrechteExtern,
                               WaagerechteExtern             => WaagerechteExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   YKoordinateExtern        => SenkrechteExtern,
                                                   XKoordinateExtern        => WaagerechteExtern,
                                                   BelegenEntfernenExtern   => False);
      
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern  => False,
                                             WachsenSchrumpfenExtern  => False);
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      SenkrechteExtern : in KartenDatentypen.Senkrechte;
      WaagerechteExtern : in KartenDatentypen.Waagerechte)
   is
      use type StadtDatentypen.Einwohner;
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
                                                      YKoordinateExtern        => SenkrechteExtern,
                                                      XKoordinateExtern        => WaagerechteExtern,
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
