pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenRecords;
with SystemKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with StadtKonstanten;

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
                                                                     KartenGrafik   => LeerKartenGrafik,
                                                                     Passierbarkeit => (others => LeerPassierbarkeit),
                                                                     FeldWerte      => (others => (others => LeerFeldWerte))
                                                                    );
   
   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
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
                                         SystemDatentypen.Karte_Größe_20_20     => 1,
                                         SystemDatentypen.Karte_Größe_40_40     => 1,
                                         SystemDatentypen.Karte_Größe_80_80     => 2,
                                         SystemDatentypen.Karte_Größe_120_80    => 3,
                                         SystemDatentypen.Karte_Größe_120_160   => 3,
                                         SystemDatentypen.Karte_Größe_160_160   => 4,
                                         SystemDatentypen.Karte_Größe_240_240   => 6,
                                         SystemDatentypen.Karte_Größe_320_320   => 8,
                                         SystemDatentypen.Karte_Größe_1000_1000 => 24,
                                         SystemDatentypen.Karte_Größe_Nutzer    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           SystemDatentypen.Karte_Größe_20_20     => 3,
                                           SystemDatentypen.Karte_Größe_40_40     => 3,
                                           SystemDatentypen.Karte_Größe_80_80     => 6,
                                           SystemDatentypen.Karte_Größe_120_80    => 9,
                                           SystemDatentypen.Karte_Größe_120_160   => 9,
                                           SystemDatentypen.Karte_Größe_160_160   => 12,
                                           SystemDatentypen.Karte_Größe_240_240   => 18,
                                           SystemDatentypen.Karte_Größe_320_320   => 24,
                                           SystemDatentypen.Karte_Größe_1000_1000 => 72,
                                           SystemDatentypen.Karte_Größe_Nutzer    => 1
                                          );

end KartenKonstanten;
