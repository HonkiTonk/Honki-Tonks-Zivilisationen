with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartengrundDatentypen;
with KartenartDatentypen;
with SystemDatentypen;

package KartengeneratorVariablenLogik is

   PolgrundOberfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Untereis_Enum;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartengeneratorRecordKonstanten.PolregionenArray := KartengeneratorRecordKonstanten.Eisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

   type StandardKartenressourcenWahrscheinlichkeitenArray is array (KartenartDatentypen.Kartenressourcenmenge_Enum'Range, KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Range) of SystemDatentypen.EinsBisHundert;
   StandardKartenressourcenWahrscheinlichkeiten : constant StandardKartenressourcenWahrscheinlichkeitenArray := (
                                                                                                                 KartenartDatentypen.Kartenressourcen_Arm_Enum =>
                                                                                                                   (
                                                                                                                    KartengrundDatentypen.Fisch_Enum              => 1,
                                                                                                                    KartengrundDatentypen.Wal_Enum                => 1,
                                                                                                                    KartengrundDatentypen.Hochwertiges_Holz_Enum  => 1,
                                                                                                                    KartengrundDatentypen.Kohle_Enum              => 1,
                                                                                                                    KartengrundDatentypen.Eisen_Enum              => 1,
                                                                                                                    KartengrundDatentypen.Öl_Enum                 => 1,
                                                                                                                    KartengrundDatentypen.Hochwertiger_Boden_Enum => 1,
                                                                                                                    KartengrundDatentypen.Gold_Enum               => 1
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Wenig_Enum =>
                                                                                                                   (
                                                                                                                    KartengrundDatentypen.Fisch_Enum              => 2,
                                                                                                                    KartengrundDatentypen.Wal_Enum                => 2,
                                                                                                                    KartengrundDatentypen.Hochwertiges_Holz_Enum  => 2,
                                                                                                                    KartengrundDatentypen.Kohle_Enum              => 2,
                                                                                                                    KartengrundDatentypen.Eisen_Enum              => 2,
                                                                                                                    KartengrundDatentypen.Öl_Enum                 => 2,
                                                                                                                    KartengrundDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                                                    KartengrundDatentypen.Gold_Enum               => 2
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Mittel_Enum =>
                                                                                                                   (
                                                                                                                    KartengrundDatentypen.Fisch_Enum              => 3,
                                                                                                                    KartengrundDatentypen.Wal_Enum                => 3,
                                                                                                                    KartengrundDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                    KartengrundDatentypen.Kohle_Enum              => 3,
                                                                                                                    KartengrundDatentypen.Eisen_Enum              => 3,
                                                                                                                    KartengrundDatentypen.Öl_Enum                 => 3,
                                                                                                                    KartengrundDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                    KartengrundDatentypen.Gold_Enum               => 3
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Viel_Enum =>
                                                                                                                   (
                                                                                                                    KartengrundDatentypen.Fisch_Enum              => 4,
                                                                                                                    KartengrundDatentypen.Wal_Enum                => 4,
                                                                                                                    KartengrundDatentypen.Hochwertiges_Holz_Enum  => 4,
                                                                                                                    KartengrundDatentypen.Kohle_Enum              => 4,
                                                                                                                    KartengrundDatentypen.Eisen_Enum              => 4,
                                                                                                                    KartengrundDatentypen.Öl_Enum                 => 4,
                                                                                                                    KartengrundDatentypen.Hochwertiger_Boden_Enum => 4,
                                                                                                                    KartengrundDatentypen.Gold_Enum               => 4
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Überfluss_Enum =>
                                                                                                                   (
                                                                                                                    KartengrundDatentypen.Fisch_Enum              => 6,
                                                                                                                    KartengrundDatentypen.Wal_Enum                => 6,
                                                                                                                    KartengrundDatentypen.Hochwertiges_Holz_Enum  => 6,
                                                                                                                    KartengrundDatentypen.Kohle_Enum              => 6,
                                                                                                                    KartengrundDatentypen.Eisen_Enum              => 6,
                                                                                                                    KartengrundDatentypen.Öl_Enum                 => 6,
                                                                                                                    KartengrundDatentypen.Hochwertiger_Boden_Enum => 6,
                                                                                                                    KartengrundDatentypen.Gold_Enum               => 6
                                                                                                                   )
                                                                                                                );

   type KartenressourcenWahrscheinlichkeitenArray is array (StandardKartenressourcenWahrscheinlichkeitenArray'Range (2)) of SystemDatentypen.NullBisHundert;
   KartenressourcenWahrscheinlichkeiten : KartenressourcenWahrscheinlichkeitenArray;

end KartengeneratorVariablenLogik;
