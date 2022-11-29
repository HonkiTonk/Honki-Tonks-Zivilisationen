with KartenKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with StadtfeldBewertenLogik;

package body FelderbewirtschaftungLogik is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Einwohner;
   begin

      case
        ZuwachsSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True,
                                                   WachsenSchrumpfenExtern => False);

            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              >= LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => False)
            then
               return;

            else
               null;
            end if;

         when True =>
            null;
      end case;

      UmgebungFestlegen (ZuwachsSchwundExtern   => ZuwachsSchwundExtern,
                         StadtRasseNummerExtern => StadtRasseNummerExtern);

      case
        ZuwachsSchwundExtern
      is
         when True =>
            ArbeiterBelegen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         when False =>
            ArbeiterEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;

   end BewirtschaftbareFelderBelegen;



   procedure UmgebungFestlegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin

      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Umgebung := (others => (others => (False, ProduktionDatentypen.Stadtproduktion'First)));

      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop

            BewirtschaftungKartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                                     ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                     LogikGrafikExtern => True);

            if
              BewirtschaftungKartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;

            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               KoordinatenExtern      => BewirtschaftungKartenwert)
            then
               null;

            elsif
              ZuwachsSchwundExtern = LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                              YKoordinateExtern      => YAchseSchleifenwert,
                                                                              XKoordinateExtern      => XAchseSchleifenwert)
            then
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt := ZuwachsSchwundExtern;

            else
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert) := (not ZuwachsSchwundExtern, StadtfeldBewertenLogik.FeldBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                                      KoordinatenExtern      => BewirtschaftungKartenwert,
                                                                                                                                      BelegenEntfernenExtern => ZuwachsSchwundExtern));
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

   end UmgebungFestlegen;



   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
      use type KartenDatentypen.Kartenfeld;
   begin

      WelchesFeld := (0, 0, 0);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop

            if
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt = True
            then
               null;

            elsif
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung > WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung, YAchseSchleifenwert, XAchseSchleifenwert);

            else
               null;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

      ArbeiterBelegenEntfernen (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                BelegenEntfernenExtern  => True,
                                WachsenSchrumpfenExtern => True,
                                FeldExtern              => WelchesFeld);

   end ArbeiterBelegen;



   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
      use type KartenDatentypen.Kartenfeld;
   begin

      WelchesFeld := (0, 0, 0);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop

            if
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt = False
            then
               null;

            elsif
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung < WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung, YAchseSchleifenwert, XAchseSchleifenwert);

            else
               null;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;

      ArbeiterBelegenEntfernen (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                BelegenEntfernenExtern  => False,
                                WachsenSchrumpfenExtern => False,
                                FeldExtern              => WelchesFeld);

   end ArbeiterEntfernen;



   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean;
      FeldExtern : in WelchesFeldRecord)
   is begin

      case
        FeldExtern.HöchsterWert
      is
         when 0 =>
            null;

         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YKoordinateExtern      => FeldExtern.YKoordinate,
                                                         XKoordinateExtern      => FeldExtern.XKoordinate,
                                                         BelegenEntfernenExtern => BelegenEntfernenExtern);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   WachsenSchrumpfenExtern => WachsenSchrumpfenExtern);
      end case;

   end ArbeiterBelegenEntfernen;

end FelderbewirtschaftungLogik;
