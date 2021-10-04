pragma SPARK_Mode (On);

pragma SPARK_Mode (On);

with KartenRecords, SystemKonstanten, KartenDatentypen, EinheitStadtDatentypen;

with DatenbankRecords;

package KartenKonstanten is

   LeerEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;

   LeerKartenPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => LeerEAchse,
                                                                                 YAchse => LeerYAchse,
                                                                                 XAchse => LeerXAchse);
   
   LeerKartenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
   LeerFeldWerte : constant EinheitStadtDatentypen.ProduktionElement := 0;
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik        => LeerKartenGrafik,
                                                                     Passierbarkeit      => (others => LeerPassierbarkeit),
                                                                     FeldWerte           => (others => (others => LeerFeldWerte))
                                                                    );
   
   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerDurchStadtBelegterGrund : constant KartenDatentypen.BelegterGrund := KartenDatentypen.BelegterGrund'First;
   LeerFelderwertung : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => LeerGrund,
                                                           Hügel                   => LeerHügel,
                                                           Sichtbar                => (others => LeerSichtbar),
                                                           Fluss                   => LeerFluss,
                                                           VerbesserungWeg         => LeerVerbesserungWeg,
                                                           VerbesserungGebiet      => LeerVerbesserungGebiet,
                                                           Ressource               => LeerRessource,
                                                           DurchStadtBelegterGrund => LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => LeerFelderwertung)
                                                          );
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerVerbesserungWerte : constant EinheitStadtDatentypen.ProduktionElement := 0;

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => LeerPassierbarkeit),
                                                                                 VerbesserungWerte  => (others => (others => LeerVerbesserungWerte))
                                                                                );
   
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         KartenDatentypen.Karte_20_20     => 1,
                                         KartenDatentypen.Karte_40_40     => 1,
                                         KartenDatentypen.Karte_80_80     => 2,
                                         KartenDatentypen.Karte_120_80    => 3,
                                         KartenDatentypen.Karte_120_160   => 3,
                                         KartenDatentypen.Karte_160_160   => 4,
                                         KartenDatentypen.Karte_240_240   => 6,
                                         KartenDatentypen.Karte_320_320   => 8,
                                         KartenDatentypen.Karte_1000_1000 => 24,
                                         KartenDatentypen.Karte_Nutzer    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           KartenDatentypen.Karte_20_20     => 3,
                                           KartenDatentypen.Karte_40_40     => 3,
                                           KartenDatentypen.Karte_80_80     => 6,
                                           KartenDatentypen.Karte_120_80    => 9,
                                           KartenDatentypen.Karte_120_160   => 9,
                                           KartenDatentypen.Karte_160_160   => 12,
                                           KartenDatentypen.Karte_240_240   => 18,
                                           KartenDatentypen.Karte_320_320   => 24,
                                           KartenDatentypen.Karte_1000_1000 => 72,
                                           KartenDatentypen.Karte_Nutzer    => 1
                                          );

end KartenKonstanten;
