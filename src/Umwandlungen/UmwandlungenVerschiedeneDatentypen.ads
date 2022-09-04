pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;
with KartenverbesserungDatentypen;
with RueckgabeDatentypen;
with RassenDatentypen;
with KartenDatentypen;
with SpielDatentypen;

package UmwandlungenVerschiedeneDatentypen is

   function TastenbelegungNachKartenverbesserung
     (TasteExtern : in TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   
   function KartenverbesserungNachTastenbelegung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum)
      return TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum;
   
   function RückgabeNachRasse
     (RückgabeExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Verwendet_Enum;
   
   function KartenartrückgabeNachKartenart
     (RückgabeExtern : in RueckgabeDatentypen.Kartenart_Enum)
      return KartenDatentypen.Kartenart_Enum;
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenDatentypen.Kartentemperatur_Enum;
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenDatentypen.Kartenressourcen_Enum;
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
private
   
   type TastenbelegungKartenverbesserungArray is array (TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum'Range) of KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   TastenbelegungKartenverbesserung : constant TastenbelegungKartenverbesserungArray := (
                                                                                         TastenbelegungDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                                                         TastenbelegungDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                                                         TastenbelegungDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
                                                                                        );
   
   type KartenverbesserungTastenbelegungArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range) of TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum;
   KartenverbesserungTastenbelegung : constant KartenverbesserungTastenbelegungArray := (
                                                                                         KartenverbesserungDatentypen.Mine_Enum    => TastenbelegungDatentypen.Mine_Bauen_Enum,
                                                                                         KartenverbesserungDatentypen.Farm_Enum    => TastenbelegungDatentypen.Farm_Bauen_Enum,
                                                                                         KartenverbesserungDatentypen.Festung_Enum => TastenbelegungDatentypen.Festung_Bauen_Enum
                                                                                        );
   
   type RückgabeRasseArray is array (RueckgabeDatentypen.Rassen_Verwendet_Enum'Range) of RassenDatentypen.Rassen_Verwendet_Enum;
   RückgabeRasse : constant RückgabeRasseArray := (
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
   
   type KartenartrückgabeKartenartArray is array (RueckgabeDatentypen.Kartenart_Enum'Range) of KartenDatentypen.Kartenart_Enum;
   KartenartrückgabeKartenart : constant KartenartrückgabeKartenartArray := (
                                                                               RueckgabeDatentypen.Kartenart_Inseln_Enum        => KartenDatentypen.Kartenart_Inseln_Enum,
                                                                               RueckgabeDatentypen.Kartenart_Kontinente_Enum    => KartenDatentypen.Kartenart_Kontinente_Enum,
                                                                               RueckgabeDatentypen.Kartenart_Pangäa_Enum        => KartenDatentypen.Kartenart_Pangäa_Enum
                                                                              );
   
   type KartentemperaturrückgabeKartentemperaturArray is array (RueckgabeDatentypen.Kartentemperatur_Enum'Range) of KartenDatentypen.Kartentemperatur_Enum;
   KartentemperaturrückgabeKartentemperatur : constant KartentemperaturrückgabeKartentemperaturArray := (
                                                                                                           RueckgabeDatentypen.Kartentemperatur_Kalt_Enum     => KartenDatentypen.Kartentemperatur_Kalt_Enum,
                                                                                                           RueckgabeDatentypen.Kartentemperatur_Gemäßigt_Enum => KartenDatentypen.Kartentemperatur_Gemäßigt_Enum,
                                                                                                           RueckgabeDatentypen.Kartentemperatur_Heiß_Enum     => KartenDatentypen.Kartentemperatur_Heiß_Enum,
                                                                                                           RueckgabeDatentypen.Kartentemperatur_Eiszeit_Enum  => KartenDatentypen.Kartentemperatur_Eiszeit_Enum,
                                                                                                           RueckgabeDatentypen.Kartentemperatur_Wüste_Enum    => KartenDatentypen.Kartentemperatur_Wüste_Enum
                                                                                                          );
   
   type KartenressourcenrückgabeKartenressourceArray is array (RueckgabeDatentypen.Kartenressourcen_Enum'Range) of KartenDatentypen.Kartenressourcen_Enum;
   KartenressourcenrückgabeKartenressource : constant KartenressourcenrückgabeKartenressourceArray := (
                                                                                                         RueckgabeDatentypen.Kartenressourcen_Arm_Enum       => KartenDatentypen.Kartenressourcen_Arm_Enum,
                                                                                                         RueckgabeDatentypen.Kartenressourcen_Wenig_Enum     => KartenDatentypen.Kartenressourcen_Wenig_Enum,
                                                                                                         RueckgabeDatentypen.Kartenressourcen_Mittel_Enum    => KartenDatentypen.Kartenressourcen_Mittel_Enum,
                                                                                                         RueckgabeDatentypen.Kartenressourcen_Viel_Enum      => KartenDatentypen.Kartenressourcen_Viel_Enum,
                                                                                                         RueckgabeDatentypen.Kartenressourcen_Überfluss_Enum => KartenDatentypen.Kartenressourcen_Überfluss_Enum
                                                                                                        );
   
   type RückgabeSchwierigkeitsgradArray is array (RueckgabeDatentypen.Schwierigkeitsgrad_Enum'Range) of SpielDatentypen.Schwierigkeitsgrad_Enum;
   RückgabeSchwierigkeitsgrad : constant RückgabeSchwierigkeitsgradArray := (
                                                                               RueckgabeDatentypen.Schwierigkeitsgrad_Leicht_Enum => SpielDatentypen.Schwierigkeitsgrad_Leicht_Enum,
                                                                               RueckgabeDatentypen.Schwierigkeitsgrad_Mittel_Enum => SpielDatentypen.Schwierigkeitsgrad_Mittel_Enum,
                                                                               RueckgabeDatentypen.Schwierigkeitsgrad_Schwer_Enum => SpielDatentypen.Schwierigkeitsgrad_Schwer_Enum
                                                                              );

end UmwandlungenVerschiedeneDatentypen;
