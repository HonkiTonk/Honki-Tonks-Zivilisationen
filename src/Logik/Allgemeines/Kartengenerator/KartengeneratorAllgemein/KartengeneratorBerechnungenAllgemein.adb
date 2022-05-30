pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;

package body KartengeneratorBerechnungenAllgemein is

   function GleicherGrundAnzahlBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder
   is begin
      
      AnzahlGleicherGrundBestimmen := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchsenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (EbeneExtern, YAchseSchleifenwert, XAchsenSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               -- Prüfung für die Änderung (0, 0) nicht benötigt, da das Feld immer mit Flachland belegt sein sollte.
               null;
                  
            elsif
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = GrundExtern
            then
               AnzahlGleicherGrundBestimmen := AnzahlGleicherGrundBestimmen + 1;
                  
            else
               null;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return AnzahlGleicherGrundBestimmen;
      
   end GleicherGrundAnzahlBestimmen;

end KartengeneratorBerechnungenAllgemein;
