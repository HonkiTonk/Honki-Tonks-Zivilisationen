with SpeziesDatentypen;

private with EinheitenDatentypen;

with LeseSpeziesbelegung;

package NaechsteEinheitLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   -- Das hier auch mal austauschen? äöü
   -- Alternativ könnte man den erweiterten Boolean aus SystemDatentypen verwenden, aber es dann linke ich halt die SystemDatentypen mir ein, ob das sinnvoll ist? äöü
   type Bewegungspunkte_Enum is (
                                 Hat_Bewegungspunkte_Enum, Keine_Bewegungspunkte_Enum, Egal_Bewegungspunkte_Enum
                                );
   
   procedure NächsteEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure NächsteEinheitMeldung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   EinheitSchleifenbegrenzung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   MeldungSchleifenbegrenzung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Bewegungspunkte : EinheitenDatentypen.Bewegungspunkte;
   
   type AktuelleEinheitArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

end NaechsteEinheitLogik;
