pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with StadtDatentypen;
private with EinheitenDatentypen;

with KIDatentypen;

package KIEinheitAufgabeAufloesenLogik is
   pragma Elaborate_Body;

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   VorhandeneEinheiten : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Aufgabenwert : KIDatentypen.AufgabenWichtigkeitKlein;
   Zwischenwert : KIDatentypen.AufgabenWichtigkeitKlein;
   
   -- Sinnvolle Werte finden äöü
   type MaximaleEinheitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of EinheitenDatentypen.MaximaleEinheiten;
   MaximaleEinheiten : constant MaximaleEinheitenArray := (
                                                           RassenDatentypen.Menschen_Enum         => 18,
                                                           RassenDatentypen.Kasrodiah_Enum        => 18,
                                                           RassenDatentypen.Lasupin_Enum          => 18,
                                                           RassenDatentypen.Lamustra_Enum         => 18,
                                                           RassenDatentypen.Manuky_Enum           => 18,
                                                           RassenDatentypen.Suroka_Enum           => 18,
                                                           RassenDatentypen.Pryolon_Enum          => 18,
                                                           RassenDatentypen.Moru_Phisihl_Enum     => 18,
                                                           RassenDatentypen.Larinos_Lotaris_Enum  => 18,
                                                           RassenDatentypen.Carupex_Enum          => 18,
                                                           RassenDatentypen.Alary_Enum            => 18,
                                                           RassenDatentypen.Natries_Zermanis_Enum => 18,
                                                           RassenDatentypen.Tridatus_Enum         => 18,
                                                           RassenDatentypen.Senelari_Enum         => 18,
                                                           RassenDatentypen.Aspari_2_Enum         => 18,
                                                           RassenDatentypen.Ekropa_Enum           => 18,
                                                           RassenDatentypen.Tesorahn_Enum         => 18,
                                                           RassenDatentypen.Talbidahr_Enum        => 18
                                                          );
   
   -- Das wird auch nochmal für den Kriegsfall benötigt. äöü
   type ZustandmalusArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KIDatentypen.Zustand_Enum'Range) of KIDatentypen.AufgabenWichtigkeitKlein;
   Zustandmalus : constant ZustandmalusArray := (
                                                 RassenDatentypen.Menschen_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Kasrodiah_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Lasupin_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Lamustra_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Manuky_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Suroka_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Pryolon_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Moru_Phisihl_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Larinos_Lotaris_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Carupex_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Alary_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Natries_Zermanis_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Tridatus_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Senelari_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Aspari_2_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Ekropa_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 0,
                                                    KIDatentypen.Geldstagnation_Enum        => 0
                                                   ),
                                       
                                                 RassenDatentypen.Tesorahn_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   ),
                                       
                                                 RassenDatentypen.Talbidahr_Enum =>
                                                   (
                                                    KIDatentypen.Hunger_Enum                => 20,
                                                    KIDatentypen.Stagniert_Enum             => 10,
                                                    KIDatentypen.Produktionsverlust_Enum    => 10,
                                                    KIDatentypen.Produktionsstagnation_Enum => 5,
                                                    KIDatentypen.Geldverlust_Enum           => 5,
                                                    KIDatentypen.Geldstagnation_Enum        => 2
                                                   )
                                                );
   
   
   
   function Stadtzustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function GlobalerZustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function StadtzustandKrieg
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitAufgabeAufloesenLogik;
