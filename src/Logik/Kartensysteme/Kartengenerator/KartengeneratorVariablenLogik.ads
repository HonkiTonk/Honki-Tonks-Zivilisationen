with SystemDatentypenHTSEB;

with KartenRecords;
with KartenRecordKonstanten;
with KartengeneratorRecordKonstanten;
with KartenartDatentypen;
with KartenrohstoffeDatentypen;
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

   type StandardKartenrohstoffeWahrscheinlichkeitenArray is array (KartenartDatentypen.Kartenrohstoffemenge_Enum'Range, KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   StandardKartenrohstoffeWahrscheinlichkeiten : constant StandardKartenrohstoffeWahrscheinlichkeitenArray := (
                                                                                                               KartenartDatentypen.Ein_Rohstoff_Enum =>
                                                                                                                 (
                                                                                                                  KartenrohstoffeDatentypen.Fisch_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Wal_Enum                => 3,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                  KartenrohstoffeDatentypen.Kohle_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Eisen_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Öl_Enum                 => 3,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                  KartenrohstoffeDatentypen.Gold_Enum               => 3
                                                                                                                 ),

                                                                                                               KartenartDatentypen.Zwei_Rohstoffe_Enum =>
                                                                                                                 (
                                                                                                                  KartenrohstoffeDatentypen.Fisch_Enum              => 2,
                                                                                                                  KartenrohstoffeDatentypen.Wal_Enum                => 2,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 2,
                                                                                                                  KartenrohstoffeDatentypen.Kohle_Enum              => 2,
                                                                                                                  KartenrohstoffeDatentypen.Eisen_Enum              => 2,
                                                                                                                  KartenrohstoffeDatentypen.Öl_Enum                 => 2,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 2,
                                                                                                                  KartenrohstoffeDatentypen.Gold_Enum               => 2
                                                                                                                 ),

                                                                                                               KartenartDatentypen.Drei_Rohstoffe_Enum =>
                                                                                                                 (
                                                                                                                  KartenrohstoffeDatentypen.Fisch_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Wal_Enum                => 3,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 3,
                                                                                                                  KartenrohstoffeDatentypen.Kohle_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Eisen_Enum              => 3,
                                                                                                                  KartenrohstoffeDatentypen.Öl_Enum                 => 3,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 3,
                                                                                                                  KartenrohstoffeDatentypen.Gold_Enum               => 3
                                                                                                                 ),

                                                                                                               KartenartDatentypen.Vier_Rohstoffe_Enum =>
                                                                                                                 (
                                                                                                                  KartenrohstoffeDatentypen.Fisch_Enum              => 4,
                                                                                                                  KartenrohstoffeDatentypen.Wal_Enum                => 4,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum  => 4,
                                                                                                                  KartenrohstoffeDatentypen.Kohle_Enum              => 4,
                                                                                                                  KartenrohstoffeDatentypen.Eisen_Enum              => 4,
                                                                                                                  KartenrohstoffeDatentypen.Öl_Enum                 => 4,
                                                                                                                  KartenrohstoffeDatentypen.Hochwertiger_Boden_Enum => 4,
                                                                                                                  KartenrohstoffeDatentypen.Gold_Enum               => 4
                                                                                                                 )
                                                                                                              );

   type KartenrohstoffeWahrscheinlichkeitenArray is array (StandardKartenrohstoffeWahrscheinlichkeitenArray'Range (2)) of SystemDatentypenHTSEB.NullBisHundert;
   KartenrohstoffeWahrscheinlichkeiten : KartenrohstoffeWahrscheinlichkeitenArray;

end KartengeneratorVariablenLogik;
