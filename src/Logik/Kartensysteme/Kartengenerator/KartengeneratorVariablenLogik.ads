with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartengrundDatentypen;
with KartenartDatentypen;
with SystemDatentypen;
with KartenextraDatentypen;

package KartengeneratorVariablenLogik is
   pragma Elaborate_Body;

   PolgrundOberfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartengrundDatentypen.Basisgrund_Vorhanden_Enum := KartengrundDatentypen.Untereis_Enum;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   Polgrößen : KartengeneratorRecordKonstanten.PolregionenArray := KartengeneratorRecordKonstanten.Eisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   SchleifenanfangOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.YXAchsenKartenfeldNaturalRecord;

   type StandardKartenressourcenWahrscheinlichkeitenArray is array (KartenartDatentypen.Kartenressourcenmenge_Enum'Range, KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range) of SystemDatentypen.EinsBisHundert;
   StandardKartenressourcenWahrscheinlichkeiten : constant StandardKartenressourcenWahrscheinlichkeitenArray := (
                                                                                                                 KartenartDatentypen.Kartenressourcen_Arm_Enum =>
                                                                                                                   (
                                                                                                                    KartenextraDatentypen.Fisch_Enum              => 1,
                                                                                                                    KartenextraDatentypen.Wal_Enum                => 1,
                                                                                                                    KartenextraDatentypen.Hochwertiges_Holz_Enum  => 1,
                                                                                                                    KartenextraDatentypen.Kohle_Enum              => 1,
                                                                                                                    KartenextraDatentypen.Eisen_Enum              => 1,
                                                                                                                    KartenextraDatentypen.Öl_Enum                 => 1,
                                                                                                                    KartenextraDatentypen.Hochwertiger_Boden_Enum => 1,
                                                                                                                    KartenextraDatentypen.Gold_Enum               => 1
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Wenig_Enum =>
                                                                                                                   (
                                                                                                                    KartenextraDatentypen.Fisch_Enum              => 2,
                                                                                                                    KartenextraDatentypen.Wal_Enum                => 2,
                                                                                                                    KartenextraDatentypen.Hochwertiges_Holz_Enum  => 2,
                                                                                                                    KartenextraDatentypen.Kohle_Enum              => 2,
                                                                                                                    KartenextraDatentypen.Eisen_Enum              => 2,
                                                                                                                    KartenextraDatentypen.Öl_Enum                 => 2,
                                                                                                                    KartenextraDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                                                    KartenextraDatentypen.Gold_Enum               => 2
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Mittel_Enum =>
                                                                                                                   (
                                                                                                                    KartenextraDatentypen.Fisch_Enum              => 3,
                                                                                                                    KartenextraDatentypen.Wal_Enum                => 3,
                                                                                                                    KartenextraDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                    KartenextraDatentypen.Kohle_Enum              => 3,
                                                                                                                    KartenextraDatentypen.Eisen_Enum              => 3,
                                                                                                                    KartenextraDatentypen.Öl_Enum                 => 3,
                                                                                                                    KartenextraDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                    KartenextraDatentypen.Gold_Enum               => 3
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Viel_Enum =>
                                                                                                                   (
                                                                                                                    KartenextraDatentypen.Fisch_Enum              => 4,
                                                                                                                    KartenextraDatentypen.Wal_Enum                => 4,
                                                                                                                    KartenextraDatentypen.Hochwertiges_Holz_Enum  => 4,
                                                                                                                    KartenextraDatentypen.Kohle_Enum              => 4,
                                                                                                                    KartenextraDatentypen.Eisen_Enum              => 4,
                                                                                                                    KartenextraDatentypen.Öl_Enum                 => 4,
                                                                                                                    KartenextraDatentypen.Hochwertiger_Boden_Enum => 4,
                                                                                                                    KartenextraDatentypen.Gold_Enum               => 4
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Überfluss_Enum =>
                                                                                                                   (
                                                                                                                    KartenextraDatentypen.Fisch_Enum              => 6,
                                                                                                                    KartenextraDatentypen.Wal_Enum                => 6,
                                                                                                                    KartenextraDatentypen.Hochwertiges_Holz_Enum  => 6,
                                                                                                                    KartenextraDatentypen.Kohle_Enum              => 6,
                                                                                                                    KartenextraDatentypen.Eisen_Enum              => 6,
                                                                                                                    KartenextraDatentypen.Öl_Enum                 => 6,
                                                                                                                    KartenextraDatentypen.Hochwertiger_Boden_Enum => 6,
                                                                                                                    KartenextraDatentypen.Gold_Enum               => 6
                                                                                                                   )
                                                                                                                );

   type KartenressourcenWahrscheinlichkeitenArray is array (StandardKartenressourcenWahrscheinlichkeitenArray'Range (2)) of SystemDatentypen.NullBisHundert;
   KartenressourcenWahrscheinlichkeiten : KartenressourcenWahrscheinlichkeitenArray;

end KartengeneratorVariablenLogik;
