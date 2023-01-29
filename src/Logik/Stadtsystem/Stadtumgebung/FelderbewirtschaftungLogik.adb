with KartenKonstanten;

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
      use type ProduktionDatentypen.Einwohner;
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
      use type KartenDatentypen.Kartenfeld;
      use type ProduktionDatentypen.Produktion;
   begin
      
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Feld.Bewertung := ProduktionDatentypen.Stadtproduktion'First;
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            Bewertung := ProduktionDatentypen.Stadtproduktion'First;
            
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern        => Kartenwert)
            then
               null;
              
            elsif
              ZuwachsSchwundExtern = LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                              YKoordinateExtern        => YAchseSchleifenwert,
                                                                              XKoordinateExtern        => XAchseSchleifenwert)
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
               Feld := (Bewertung, YAchseSchleifenwert, XAchseSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
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
