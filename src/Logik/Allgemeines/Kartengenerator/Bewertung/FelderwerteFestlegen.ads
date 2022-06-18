pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen;
with KartenRecords;

with Karten;

package FelderwerteFestlegen is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
   procedure KartenfelderBewertenKleineSchleife
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
private
      
   type KartenwertArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertEins : KartenwertArray;
   KartenWertZwei : KartenwertArray;
   
   type TeilerArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.UmgebungsbereichDrei;
   Teiler : TeilerArray;
   
   type BewertungArray is array (KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.GesamteFeldbewertung;
   Bewertung : BewertungArray;
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenUmgebungExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Enum;
      TeilerExtern : in KartenDatentypen.UmgebungsbereichDrei)
     with
       Pre =>
         (KoordinatenFeldExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenFeldExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            TeilerExtern > 0);

end FelderwerteFestlegen;
