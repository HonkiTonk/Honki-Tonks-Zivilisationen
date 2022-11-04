pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with RueckgabeDatentypen;
with RassenDatentypen;
with SpielDatentypen;
with BefehleDatentypen;
with KartenartDatentypen;

package UmwandlungenVerschiedeneDatentypen is
   pragma Pure;

   function BefehleNachKartenverbesserung
     (TasteExtern : in BefehleDatentypen.Siedler_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   
   function KartenverbesserungNachBefehle
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum)
      return BefehleDatentypen.Siedler_Konstruktionen_Enum;
   
   function RückgabeNachRasse
     (RückgabeExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Verwendet_Enum;
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenartDatentypen.Kartentemperatur_Enum;
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenartDatentypen.Kartenressourcen_Enum;
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
private
   
   type BefehleKartenverbesserungArray is array (BefehleDatentypen.Siedler_Konstruktionen_Enum'Range) of KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   BefehleKartenverbesserung : constant BefehleKartenverbesserungArray := (
                                                                           BefehleDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                                           BefehleDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                                           BefehleDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
                                                                          );
   
   type KartenverbesserungBefehleArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range) of BefehleDatentypen.Siedler_Konstruktionen_Enum;
   KartenverbesserungBefehle : constant KartenverbesserungBefehleArray := (
                                                                           KartenverbesserungDatentypen.Mine_Enum    => BefehleDatentypen.Mine_Bauen_Enum,
                                                                           KartenverbesserungDatentypen.Farm_Enum    => BefehleDatentypen.Farm_Bauen_Enum,
                                                                           KartenverbesserungDatentypen.Festung_Enum => BefehleDatentypen.Festung_Bauen_Enum
                                                                                        );
   
   type RückgabeRasseArray is array (RueckgabeDatentypen.Rassen_Verwendet_Enum'Range) of RassenDatentypen.Rassen_Verwendet_Enum;
   RückgabeRasse : constant RückgabeRasseArray := (
                                                     RueckgabeDatentypen.Auswahl_Eins_Enum     => RassenDatentypen.Menschen_Enum,
                                                     RueckgabeDatentypen.Auswahl_Zwei_Enum     => RassenDatentypen.Kasrodiah_Enum,
                                                     RueckgabeDatentypen.Auswahl_Drei_Enum     => RassenDatentypen.Lasupin_Enum,
                                                     RueckgabeDatentypen.Auswahl_Vier_Enum     => RassenDatentypen.Lamustra_Enum,
                                                     RueckgabeDatentypen.Auswahl_Fünf_Enum     => RassenDatentypen.Manuky_Enum,
                                                     RueckgabeDatentypen.Auswahl_Sechs_Enum    => RassenDatentypen.Suroka_Enum,
                                                     RueckgabeDatentypen.Auswahl_Sieben_Enum   => RassenDatentypen.Pryolon_Enum,
                                                     RueckgabeDatentypen.Auswahl_Acht_Enum     => RassenDatentypen.Moru_Phisihl_Enum,
                                                     RueckgabeDatentypen.Auswahl_Neun_Enum     => RassenDatentypen.Larinos_Lotaris_Enum,
                                                     RueckgabeDatentypen.Auswahl_Zehn_Enum     => RassenDatentypen.Carupex_Enum,
                                                     RueckgabeDatentypen.Auswahl_Elf_Enum      => RassenDatentypen.Alary_Enum,
                                                     RueckgabeDatentypen.Auswahl_Zwölf_Enum    => RassenDatentypen.Natries_Zermanis_Enum,
                                                     RueckgabeDatentypen.Auswahl_Dreizehn_Enum => RassenDatentypen.Tridatus_Enum,
                                                     RueckgabeDatentypen.Auswahl_Vierzehn_Enum => RassenDatentypen.Senelari_Enum,
                                                     RueckgabeDatentypen.Auswahl_Fünfzehn_Enum => RassenDatentypen.Aspari_2_Enum,
                                                     RueckgabeDatentypen.Auswahl_Sechzehn_Enum => RassenDatentypen.Ekropa_Enum,
                                                     RueckgabeDatentypen.Auswahl_Siebzehn_Enum => RassenDatentypen.Tesorahn_Enum,
                                                     RueckgabeDatentypen.Auswahl_Achtzehn_Enum => RassenDatentypen.Talbidahr_Enum
                                                    );
   
   type KartentemperaturrückgabeKartentemperaturArray is array (RueckgabeDatentypen.Kartentemperatur_Enum'Range) of KartenartDatentypen.Kartentemperatur_Enum;
   KartentemperaturrückgabeKartentemperatur : constant KartentemperaturrückgabeKartentemperaturArray := (
                                                                                                           RueckgabeDatentypen.Auswahl_Eins_Enum => KartenartDatentypen.Kartentemperatur_Kalt_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Zwei_Enum => KartenartDatentypen.Kartentemperatur_Gemäßigt_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Drei_Enum => KartenartDatentypen.Kartentemperatur_Heiß_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Vier_Enum => KartenartDatentypen.Kartentemperatur_Eiszeit_Enum,
                                                                                                           RueckgabeDatentypen.Auswahl_Fünf_Enum => KartenartDatentypen.Kartentemperatur_Wüste_Enum
                                                                                                          );
   
   type KartenressourcenrückgabeKartenressourceArray is array (RueckgabeDatentypen.Kartenressourcen_Enum'Range) of KartenartDatentypen.Kartenressourcen_Enum;
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
