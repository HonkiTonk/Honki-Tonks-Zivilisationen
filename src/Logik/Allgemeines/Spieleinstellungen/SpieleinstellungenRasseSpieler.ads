pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;

private with RueckgabeDatentypen;
private with KartenRecords;
private with ZahlenDatentypen;

private with Karten;

package SpieleinstellungenRasseSpieler is
   
   procedure StartwerteErmitteln;
   procedure RassenWählen;
   procedure RasseAutomatischBelegen;
   procedure RasseBelegenSchnellstart;
   
   
   
   function EineRasseBelegt
     return Boolean;
   
private
   
   StartpositionGefunden : Boolean;
   
   FelderGefunden : KartenDatentypen.SichtweiteNatural;
   FreieFelder : KartenDatentypen.SichtweiteNatural;
   
   RassenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   RasseMenschSchnellstart : RassenDatentypen.Rassen_Verwendet_Enum;
   RasseKISchnellstart : RassenDatentypen.Rassen_Verwendet_Enum;
   
   GezogeneWerte : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
      
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
   
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldNaturalRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure BelegungÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure StartpunktFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   

   function UmgebungPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function FelderBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteNatural
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end SpieleinstellungenRasseSpieler;
