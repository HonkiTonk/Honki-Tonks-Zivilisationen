pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with RueckgabeDatentypen;
with GlobaleVariablen;
with KartenRecords;

with Karten;

package SpieleinstellungenRasseSpieler is

   procedure StartwerteErmitteln;

   procedure StartpunktFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure RassenWählen;
   
   

   function UmgebungPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function EineRasseBelegt
     return Boolean;
   
private
   
   StartpositionGefunden : Boolean;
   
   FreieFelder : KartenDatentypen.SichtweiteMitNullwert;
   
   RassenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   GezogeneWerte : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type NotAus is range 1 .. 100;
   
   type RückgabeZuRasseArray is array (RueckgabeDatentypen.Rassen_Verwendet_Enum'Range) of RassenDatentypen.Rassen_Verwendet_Enum;
   RückgabeZuRasse : constant RückgabeZuRasseArray := (
                                                         RueckgabeDatentypen.Menschen_Enum         => RassenDatentypen.Menschen_Enum,
                                                         RueckgabeDatentypen.Kasrodiah_Enum        => RassenDatentypen.Kasrodiah_Enum,
                                                         RueckgabeDatentypen.Lasupin_Enum          => RassenDatentypen.Lasupin_Enum,
                                                         RueckgabeDatentypen.Lamustra_Enum         => RassenDatentypen.Lamustra_Enum,
                                                         RueckgabeDatentypen.Manuky_Enum           => RassenDatentypen.Manuky_Enum,
                                                         RueckgabeDatentypen.Suroka_Enum           => RassenDatentypen.Suroka_Enum,
                                                         RueckgabeDatentypen.Pryolon_Enum          => RassenDatentypen.Pryolon_Enum,
                                                         RueckgabeDatentypen.Talbidahr_Enum        => RassenDatentypen.Talbidahr_Enum,
                                                         RueckgabeDatentypen.Moru_Phisihl_Enum     => RassenDatentypen.Moru_Phisihl_Enum,
                                                         RueckgabeDatentypen.Larinos_Lotaris_Enum  => RassenDatentypen.Larinos_Lotaris_Enum,
                                                         RueckgabeDatentypen.Carupex_Enum          => RassenDatentypen.Carupex_Enum,
                                                         RueckgabeDatentypen.Alary_Enum            => RassenDatentypen.Alary_Enum,
                                                         RueckgabeDatentypen.Tesorahn_Enum         => RassenDatentypen.Tesorahn_Enum,
                                                         RueckgabeDatentypen.Natries_Zermanis_Enum => RassenDatentypen.Natries_Zermanis_Enum,
                                                         RueckgabeDatentypen.Tridatus_Enum         => RassenDatentypen.Tridatus_Enum,
                                                         RueckgabeDatentypen.Senelari_Enum         => RassenDatentypen.Senelari_Enum,
                                                         RueckgabeDatentypen.Aspari_2_Enum         => RassenDatentypen.Aspari_2_Enum,
                                                         RueckgabeDatentypen.Ekropa_Enum           => RassenDatentypen.Ekropa_Enum
                                                        );
   
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldPositivRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure FelderBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure BelegungÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end SpieleinstellungenRasseSpieler;
