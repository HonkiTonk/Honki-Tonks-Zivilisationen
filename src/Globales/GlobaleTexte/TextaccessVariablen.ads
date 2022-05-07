pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen;
with EinheitStadtDatentypen;
with ForschungenDatentypen;

with InteraktionAuswahl;

package TextaccessVariablen is

   -- MenüsEinfach
   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;
   
   type MenüsEinfachSFMLAccessArray is array (InteraktionAuswahl.PositionenMenüeinträgeArray'Range (1),
                                               Überschrift .. Überschrift + InteraktionAuswahl.PositionenMenüeinträgeArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   MenüsEinfachSFMLAccess : constant MenüsEinfachSFMLAccessArray := (
                                                                       others =>
                                                                         (
                                                                          others => Sf.Graphics.Text.create
                                                                         )
                                                                      );
   -- MenüsEinfach
   
   
   
   -- ZusatztextRassenmenü
   type ZusatztextRassenAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.sfText_Ptr;
   ZusatztextRassenAccess : constant ZusatztextRassenAccessArray := (
                                                                     others => Sf.Graphics.Text.create
                                                                    );
   -- ZusatztextRassenmenü
   
   
   
   -- ZusatztextKartengröße
   type ZusatztextKartengrößeAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   ZusatztextKartengrößeAccess : constant ZusatztextKartengrößeAccessArray := (
                                                                                   others => Sf.Graphics.Text.create
                                                                                  );
   -- ZusatztextKartengröße
   
   
   
   -- Baumenü
   BaumenüÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   type GebäudetextAccessArray is array (EinheitStadtDatentypen.GebäudeIDMitNullwert'Range) of Sf.Graphics.sfText_Ptr;
   GebäudetextAccess : constant GebäudetextAccessArray := (others => Sf.Graphics.Text.create);

   type GebäudezusatztextAccessArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfText_Ptr;
   GebäudezusatztextAccess : constant GebäudezusatztextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitentextAccessArray is array (EinheitStadtDatentypen.EinheitenIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   EinheitentextAccess : constant EinheitentextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitenzusatztextAccessArray is array (EinheitStadtDatentypen.EinheitenID'Range) of Sf.Graphics.sfText_Ptr;
   EinheitenzusatztextAccess : constant EinheitenzusatztextAccessArray := (others => Sf.Graphics.Text.create);
   -- Baumenü
   
   
   
   -- Forschungsmenü
   type ForschungsmenüAccessArray is array (ForschungenDatentypen.ForschungIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüAccess : constant ForschungsmenüAccessArray := (others => Sf.Graphics.Text.create);
   
   type ForschungsmenüZusatztextAccessArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüZusatztextAccess : constant ForschungsmenüZusatztextAccessArray := (others => Sf.Graphics.Text.create);
   -- Forschungsmenü
   
   
   
   --
   
   --

end TextaccessVariablen;
