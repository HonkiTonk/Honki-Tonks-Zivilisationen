pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenRecords;
with SystemKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with StadtKonstanten;

with DatenbankRecords;

package KartenKonstanten is
   
   -- Für Karteneinstellungen
   RessourcenArmKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Arm;
   RessourcenWenigKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Wenig;
   RessourcenMittelKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Mittel;
   RessourcenVielKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Viel;
   RessourcenÜberflussKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Überfluss;
   -- Für Karteneinstellungen
   
   

   LeerEAchse : constant KartenDatentypen.EbeneVorhanden := KartenDatentypen.EbeneVorhanden'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;

   LeerKartenPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => LeerEAchse,
                                                                                 YAchse => LeerYAchse,
                                                                                 XAchse => LeerXAchse);
   
   LeerKartenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik   => LeerKartenGrafik,
                                                                     Passierbarkeit => (others => LeerPassierbarkeit),
                                                                     Bewertung      => (others => LeerBewertung),
                                                                     Wirtschaft     => (others => (others => LeerWirtschaft)),
                                                                     Kampf          => (others => (others => LeerKampf))
                                                                    );
   
   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
   LeerFelderwertung : constant KartenDatentypen.GesamtbewertungFeld := 0;

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
      
   LeerVerbesserungBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerVerbesserungWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerVerbesserungKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => LeerPassierbarkeit),
                                                                                 Bewertung          => (others => LeerVerbesserungBewertung),
                                                                                 Wirtschaft         => (others => (others => LeerVerbesserungWirtschaft)),
                                                                                 Kampf              => (others => (others => LeerVerbesserungKampf))
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
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff;

end KartenKonstanten;
