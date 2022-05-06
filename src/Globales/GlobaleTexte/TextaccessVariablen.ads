pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;

with InteraktionAuswahl;

package TextaccessVariablen is

   -- AuswahlMenuesEinfachSFML
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
   -- MenuesEinfachSFML

end TextaccessVariablen;
