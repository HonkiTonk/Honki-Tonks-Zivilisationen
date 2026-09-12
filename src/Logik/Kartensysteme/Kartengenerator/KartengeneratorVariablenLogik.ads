with SystemDatentypenHTSEB;

with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;
with KartenressourcenDatentypen;
with KartenbasisgrundDatentypen;


-- Die Sachen hier auch mal mit Lese/Schreibefunktionen versehen. äöü
package KartengeneratorVariablenLogik is
   pragma Elaborate_Body;

   PolgrundOberfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Eis_Enum;
   PolgrundUnterfläche : KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum := KartenbasisgrundDatentypen.Untereis_Enum;

   Kartenparameter : KartenRecords.TemporäreKartenparameterRecord := KartenRecordKonstanten.Standardkartengeneratorparameter;

   SenkrechtePolgrößen : KartengeneratorRecordKonstanten.SenkrechtePolregionenArray := KartengeneratorRecordKonstanten.SenkrechterEisrand;
   WaagerechtePolgrößen : KartengeneratorRecordKonstanten.WaagerechtePolregionenArray := KartengeneratorRecordKonstanten.WaagerechterEisrand;

   -- Alle Angaben sind Radien.
   Landgrößen : KartenRecords.LandgrößenRecord := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   SchleifenanfangOhnePolbereich : KartenRecords.KartenfeldumgebungNaturalRecord;
   SchleifenendeOhnePolbereich : KartenRecords.KartenfeldumgebungNaturalRecord;

   type StandardKartenressourcenWahrscheinlichkeitenArray is array (KartenartDatentypen.Kartenressourcenmenge_Enum'Range, KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   StandardKartenressourcenWahrscheinlichkeiten : constant StandardKartenressourcenWahrscheinlichkeitenArray := (
                                                                                                                 KartenartDatentypen.Kartenressourcen_Keine_Enum =>
                                                                                                                   (
                                                                                                                    others => 0
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Arm_Enum =>
                                                                                                                   (
                                                                                                                    KartenressourcenDatentypen.Fisch_Enum              => 1,
                                                                                                                    KartenressourcenDatentypen.Wal_Enum                => 1,
                                                                                                                    KartenressourcenDatentypen.Hochwertiges_Holz_Enum  => 1,
                                                                                                                    KartenressourcenDatentypen.Kohle_Enum              => 1,
                                                                                                                    KartenressourcenDatentypen.Eisen_Enum              => 1,
                                                                                                                    KartenressourcenDatentypen.Öl_Enum                 => 1,
                                                                                                                    KartenressourcenDatentypen.Hochwertiger_Boden_Enum => 1,
                                                                                                                    KartenressourcenDatentypen.Gold_Enum               => 1
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Wenig_Enum =>
                                                                                                                   (
                                                                                                                    KartenressourcenDatentypen.Fisch_Enum              => 2,
                                                                                                                    KartenressourcenDatentypen.Wal_Enum                => 2,
                                                                                                                    KartenressourcenDatentypen.Hochwertiges_Holz_Enum  => 2,
                                                                                                                    KartenressourcenDatentypen.Kohle_Enum              => 2,
                                                                                                                    KartenressourcenDatentypen.Eisen_Enum              => 2,
                                                                                                                    KartenressourcenDatentypen.Öl_Enum                 => 2,
                                                                                                                    KartenressourcenDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                                                    KartenressourcenDatentypen.Gold_Enum               => 2
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Mittel_Enum =>
                                                                                                                   (
                                                                                                                    KartenressourcenDatentypen.Fisch_Enum              => 3,
                                                                                                                    KartenressourcenDatentypen.Wal_Enum                => 3,
                                                                                                                    KartenressourcenDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                    KartenressourcenDatentypen.Kohle_Enum              => 3,
                                                                                                                    KartenressourcenDatentypen.Eisen_Enum              => 3,
                                                                                                                    KartenressourcenDatentypen.Öl_Enum                 => 3,
                                                                                                                    KartenressourcenDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                    KartenressourcenDatentypen.Gold_Enum               => 3
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Viel_Enum =>
                                                                                                                   (
                                                                                                                    KartenressourcenDatentypen.Fisch_Enum              => 4,
                                                                                                                    KartenressourcenDatentypen.Wal_Enum                => 4,
                                                                                                                    KartenressourcenDatentypen.Hochwertiges_Holz_Enum  => 4,
                                                                                                                    KartenressourcenDatentypen.Kohle_Enum              => 4,
                                                                                                                    KartenressourcenDatentypen.Eisen_Enum              => 4,
                                                                                                                    KartenressourcenDatentypen.Öl_Enum                 => 4,
                                                                                                                    KartenressourcenDatentypen.Hochwertiger_Boden_Enum => 4,
                                                                                                                    KartenressourcenDatentypen.Gold_Enum               => 4
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Überfluss_Enum =>
                                                                                                                   (
                                                                                                                    KartenressourcenDatentypen.Fisch_Enum              => 6,
                                                                                                                    KartenressourcenDatentypen.Wal_Enum                => 6,
                                                                                                                    KartenressourcenDatentypen.Hochwertiges_Holz_Enum  => 6,
                                                                                                                    KartenressourcenDatentypen.Kohle_Enum              => 6,
                                                                                                                    KartenressourcenDatentypen.Eisen_Enum              => 6,
                                                                                                                    KartenressourcenDatentypen.Öl_Enum                 => 6,
                                                                                                                    KartenressourcenDatentypen.Hochwertiger_Boden_Enum => 6,
                                                                                                                    KartenressourcenDatentypen.Gold_Enum               => 6
                                                                                                                   ),

                                                                                                                 KartenartDatentypen.Kartenressourcen_Überall_Enum =>
                                                                                                                   (
                                                                                                                    others => 100
                                                                                                                   )
                                                                                                                );

   type KartenressourcenWahrscheinlichkeitenArray is array (StandardKartenressourcenWahrscheinlichkeitenArray'Range (2)) of SystemDatentypenHTSEB.NullBisHundert;
   KartenressourcenWahrscheinlichkeiten : KartenressourcenWahrscheinlichkeitenArray;

end KartengeneratorVariablenLogik;
