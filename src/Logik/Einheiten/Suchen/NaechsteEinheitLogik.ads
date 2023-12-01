with SpeziesDatentypen;

private with EinheitenDatentypen;

with LeseSpeziesbelegung;

package NaechsteEinheitLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   -- Das hier auch mal austauschen? äöü
   -- Alternativ könnte man den erweiterten Boolean aus SystemDatentypen verwenden, aber dann linke ich halt die SystemDatentypen mit ein, ob das sinnvoll ist? äöü
   type Bewegungspunkte_Enum is (
                                 Hat_Bewegungspunkte_Enum, Keine_Bewegungspunkte_Enum, Egal_Bewegungspunkte_Enum
                                );
   
   procedure NächsteEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BewegungspunkteExtern : in Bewegungspunkte_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure NächsteEinheitMeldung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   EinheitSchleifenbegrenzung : EinheitenDatentypen.Einheitenbereich;
   MeldungSchleifenbegrenzung : EinheitenDatentypen.Einheitenbereich;
   
   Bewegungspunkte : EinheitenDatentypen.Bewegungspunkte;
   
   type AktuelleEinheitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of EinheitenDatentypen.Einheitenbereich;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

end NaechsteEinheitLogik;
