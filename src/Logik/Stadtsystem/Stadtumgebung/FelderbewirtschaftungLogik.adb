with KartenKonstanten;
with StadtDatentypen;
with SystemDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with StadtfeldBewertenLogik;

package body FelderbewirtschaftungLogik is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.Einwohner;
   begin
      
      case
        ZuwachsSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   EinwohnerArbeiterExtern  => True,
                                                   WachsenSchrumpfenExtern  => False);
            
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                 EinwohnerArbeiterExtern  => True)
              >= LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                    EinwohnerArbeiterExtern  => False)
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            null;
      end case;
      
      ArbeiterBelegenEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                BelegenEntfernenExtern   => ZuwachsSchwundExtern,
                                WachsenSchrumpfenExtern  => ZuwachsSchwundExtern,
                                FeldExtern               => OptimalesFeldErmitteln (ZuwachsSchwundExtern     => ZuwachsSchwundExtern,
                                                                                    StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      
   end BewirtschaftbareFelderBelegen;
   
   
   
   function OptimalesFeldErmitteln
     (ZuwachsSchwundExtern : in Boolean;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return FeldRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
      use type ProduktionDatentypen.Produktion;
   begin
      
      NutzbarerBereich := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Feld.Bewertung := ProduktionDatentypen.Stadtproduktion'First;
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -NutzbarerBereich.Senkrechte .. NutzbarerBereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -NutzbarerBereich.Waagerechte .. NutzbarerBereich.Waagerechte loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            Bewertung := ProduktionDatentypen.Stadtproduktion'First;
            
            if
              Kartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern        => Kartenwert)
            then
               null;
              
            elsif
              ZuwachsSchwundExtern = LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                              YKoordinateExtern        => SenkrechteSchleifenwert,
                                                                              XKoordinateExtern        => WaagerechteSchleifenwert)
            then
               null;
               
            else
               Bewertung := StadtfeldBewertenLogik.FeldBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                 KoordinatenExtern        => Kartenwert,
                                                                 BelegenEntfernenExtern   => ZuwachsSchwundExtern);
            end if;
            
            if
              Feld.Bewertung < Bewertung
            then
               Feld := (Bewertung, SenkrechteSchleifenwert, WaagerechteSchleifenwert);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return Feld;
      
   end OptimalesFeldErmitteln;
   
   
   
   procedure ArbeiterBelegenEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean;
      FeldExtern : in FeldRecord)
   is begin
      
      case
        FeldExtern.Bewertung
      is
         when ProduktionDatentypen.Stadtproduktion'First =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                         YKoordinateExtern        => FeldExtern.YKoordinate,
                                                         XKoordinateExtern        => FeldExtern.XKoordinate,
                                                         BelegenEntfernenExtern   => BelegenEntfernenExtern);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   EinwohnerArbeiterExtern  => False,
                                                   WachsenSchrumpfenExtern  => WachsenSchrumpfenExtern);
      end case;
      
   end ArbeiterBelegenEntfernen;

end FelderbewirtschaftungLogik;
