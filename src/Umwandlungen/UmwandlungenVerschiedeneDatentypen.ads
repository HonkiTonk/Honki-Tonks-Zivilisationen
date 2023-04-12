with KartenverbesserungDatentypen;
with RueckgabeDatentypen;
with SpeziesDatentypen;
with SpielDatentypen;
with BefehleDatentypen;
with KartenartDatentypen;

package UmwandlungenVerschiedeneDatentypen is
   pragma Pure;

   function BefehleNachKartenverbesserung
     (TasteExtern : in BefehleDatentypen.Siedler_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum;
   
   function KartenverbesserungNachBefehle
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum)
      return BefehleDatentypen.Siedler_Konstruktionen_Enum;
   
   function RückgabeNachSpezies
     (RückgabeExtern : in RueckgabeDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Verwendet_Enum;
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenartDatentypen.Kartentemperatur_Enum;
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenartDatentypen.Kartenressourcenmenge_Enum;
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
private
   
   type BefehleKartenverbesserungArray is array (BefehleDatentypen.Siedler_Konstruktionen_Enum'Range) of KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum;
   BefehleKartenverbesserung : constant BefehleKartenverbesserungArray := (
                                                                           BefehleDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                                           BefehleDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                                           BefehleDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
                                                                          );
   
   type KartenverbesserungBefehleArray is array (KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum'Range) of BefehleDatentypen.Siedler_Konstruktionen_Enum;
   KartenverbesserungBefehle : constant KartenverbesserungBefehleArray := (
                                                                           KartenverbesserungDatentypen.Mine_Enum    => BefehleDatentypen.Mine_Bauen_Enum,
                                                                           KartenverbesserungDatentypen.Farm_Enum    => BefehleDatentypen.Farm_Bauen_Enum,
                                                                           KartenverbesserungDatentypen.Festung_Enum => BefehleDatentypen.Festung_Bauen_Enum
                                                                          );
   
   type RückgabeSpeziesArray is array (RueckgabeDatentypen.Spezies_Verwendet_Enum'Range) of SpeziesDatentypen.Spezies_Verwendet_Enum;
   RückgabeSpezies : constant RückgabeSpeziesArray := (
                                                         RueckgabeDatentypen.Auswahl_Eins_Enum     => SpeziesDatentypen.Menschen_Enum,
                                                         RueckgabeDatentypen.Auswahl_Zwei_Enum     => SpeziesDatentypen.Kasrodiah_Enum,
                                                         RueckgabeDatentypen.Auswahl_Drei_Enum     => SpeziesDatentypen.Lasupin_Enum,
                                                         RueckgabeDatentypen.Auswahl_Vier_Enum     => SpeziesDatentypen.Lamustra_Enum,
                                                         RueckgabeDatentypen.Auswahl_Fünf_Enum     => SpeziesDatentypen.Manuky_Enum,
                                                         RueckgabeDatentypen.Auswahl_Sechs_Enum    => SpeziesDatentypen.Suroka_Enum,
                                                         RueckgabeDatentypen.Auswahl_Sieben_Enum   => SpeziesDatentypen.Pryolon_Enum,
                                                         RueckgabeDatentypen.Auswahl_Acht_Enum     => SpeziesDatentypen.Moru_Phisihl_Enum,
                                                         RueckgabeDatentypen.Auswahl_Neun_Enum     => SpeziesDatentypen.Larinos_Lotaris_Enum,
                                                         RueckgabeDatentypen.Auswahl_Zehn_Enum     => SpeziesDatentypen.Carupex_Enum,
                                                         RueckgabeDatentypen.Auswahl_Elf_Enum      => SpeziesDatentypen.Alary_Enum,
                                                         RueckgabeDatentypen.Auswahl_Zwölf_Enum    => SpeziesDatentypen.Natries_Zermanis_Enum,
                                                         RueckgabeDatentypen.Auswahl_Dreizehn_Enum => SpeziesDatentypen.Tridatus_Enum,
                                                         RueckgabeDatentypen.Auswahl_Vierzehn_Enum => SpeziesDatentypen.Senelari_Enum,
                                                         RueckgabeDatentypen.Auswahl_Fünfzehn_Enum => SpeziesDatentypen.Aspari_2_Enum,
                                                         RueckgabeDatentypen.Auswahl_Sechzehn_Enum => SpeziesDatentypen.Ekropa_Enum,
                                                         RueckgabeDatentypen.Auswahl_Siebzehn_Enum => SpeziesDatentypen.Tesorahn_Enum,
                                                         RueckgabeDatentypen.Auswahl_Achtzehn_Enum => SpeziesDatentypen.Talbidahr_Enum
                                                        );
   
   type KartentemperaturrückgabeKartentemperaturArray is array (RueckgabeDatentypen.Kartentemperatur_Enum'Range) of KartenartDatentypen.Kartentemperatur_Enum;
   KartentemperaturrückgabeKartentemperatur : constant KartentemperaturrückgabeKartentemperaturArray := (
                                                                                                           RueckgabeDatentypen.Auswahl_Eins_Enum => KartenartDatentypen.Kartentemperatur_Kalt_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Zwei_Enum => KartenartDatentypen.Kartentemperatur_Gemäßigt_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Drei_Enum => KartenartDatentypen.Kartentemperatur_Heiß_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Vier_Enum => KartenartDatentypen.Kartentemperatur_Eiszeit_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Fünf_Enum => KartenartDatentypen.Kartentemperatur_Wüste_Enum
                                                                                                          );
   
   type KartenressourcenrückgabeKartenressourceArray is array (RueckgabeDatentypen.Kartenressourcen_Enum'Range) of KartenartDatentypen.Kartenressourcenmenge_Enum;
   KartenressourcenrückgabeKartenressource : constant KartenressourcenrückgabeKartenressourceArray := (
                                                                                                         RueckgabeDatentypen.Auswahl_Eins_Enum => KartenartDatentypen.Kartenressourcen_Arm_Enum,
                                                                                                         RueckgabeDatentypen.Auswahl_Zwei_Enum => KartenartDatentypen.Kartenressourcen_Wenig_Enum,
                                                                                                         RueckgabeDatentypen.Auswahl_Drei_Enum => KartenartDatentypen.Kartenressourcen_Mittel_Enum,
                                                                                                         RueckgabeDatentypen.Auswahl_Vier_Enum => KartenartDatentypen.Kartenressourcen_Viel_Enum,
                                                                                                         RueckgabeDatentypen.Auswahl_Fünf_Enum => KartenartDatentypen.Kartenressourcen_Überfluss_Enum
                                                                                                        );
   
   type RückgabeSchwierigkeitsgradArray is array (RueckgabeDatentypen.Schwierigkeitsgrad_Enum'Range) of SpielDatentypen.Schwierigkeitsgrad_Enum;
   RückgabeSchwierigkeitsgrad : constant RückgabeSchwierigkeitsgradArray := (
                                                                               RueckgabeDatentypen.Auswahl_Eins_Enum => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                               RueckgabeDatentypen.Auswahl_Zwei_Enum => SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum,
                                                                               RueckgabeDatentypen.Auswahl_Drei_Enum => SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum
                                                                              );

end UmwandlungenVerschiedeneDatentypen;
