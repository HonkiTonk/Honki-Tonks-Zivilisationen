private with Ada.Numerics.Elementary_Functions;

private with Sf.System.Vector2;
private with Sf;

private with SpeziesDatentypen;

private with TexturenfelderVariablenGrafik;

-- Alle Texturen müssen quadratisch angeordnet sein, damit ich die Wurzelfunktion nutzen kann.
package TexturenfelderBerechnenGrafik is
   pragma Elaborate_Body;

   procedure TexturenfelderBerechnen;
   
private
   use Ada.Numerics.Elementary_Functions;
   
   FelderanzahlBasisgrund : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.BasisgrundArray'Length)))),
                                                                      Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.BasisgrundArray'Length)))));
   
   FelderanzahlZusatzgrund : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.ZusatzgrundArray'Length)))),
                                                                       Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.ZusatzgrundArray'Length)))));
   
   FelderanzahlFlüsse : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.FlüsseArray'Length)))),
                                                                   Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.FlüsseArray'Length)))));
   
   FelderanzahlRohstoffe : constant Sf.System.Vector2.sfVector2u := (3, 3); -- (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.RohstoffeArray'Length)))),
   -- Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.RohstoffeArray'Length)))));
   
   FelderanzahlVerbesserungen : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.VerbesserungenArray'Length)))),
                                                                          Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.VerbesserungenArray'Length)))));
   
   FelderanzahlWege : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.WegeArray'Length)))),
                                                                Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.WegeArray'Length)))));
   
   FelderanzahlFeldeffekte : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.FeldeffekteArray'Length)))),
                                                                       Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.FeldeffekteArray'Length)))));
   
   FelderanzahlAllgemeinesSpezien : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.AllgemeinesSpezienArray'Length (2))))),
                                                                              Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.AllgemeinesSpezienArray'Length (2))))));
   
   FelderanzahlEinheiten : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.EinheitenArray'Length (2))))),
                                                                     Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.EinheitenArray'Length (2))))));
   
   FelderanzahlGebäude : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.GebäudeArray'Length (2))))),
                                                                    Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.GebäudeArray'Length (2))))));
   
   FelderanzahlIntro : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.IntroArray'Length)))),
                                                                 Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.IntroArray'Length)))));
   
   FelderanzahlOutro : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.OutroArray'Length)))),
                                                                 Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.OutroArray'Length)))));
   
   FelderanzahlAllgemeines : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.AllgemeinesArray'Length)))),
                                                                       Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.AllgemeinesArray'Length)))));
   
   FelderanzahlKartenbefehle : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.KartenbefehleArray'Length)))),
                                                                         Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.KartenbefehleArray'Length)))));
   
   FelderanzahlEinheitenbefehle : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.EinheitenbefehleArray'Length)))),
                                                                        Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.EinheitenbefehleArray'Length)))));
   
   FelderanzahlKartenformen : constant Sf.System.Vector2.sfVector2u := (Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.KartenformenArray'Length)))),
                                                                        Sf.sfUint32 (Float'Ceiling (Sqrt (Float (TexturenfelderVariablenGrafik.KartenformenArray'Length)))));
         
   
   
   -- FelderanzahlRoterKnopf : constant Sf.System.Vector2.sfVector2u := (1, 1);
   -- FelderanzahlSeitenleiste : constant Sf.System.Vector2.sfVector2u := (1, 1);
   -- FelderanzahlPZBEnde : constant Sf.System.Vector2.sfVector2u := (1, 1);
   
   Feldgröße : Sf.System.Vector2.sfVector2u;
   Texturengröße : Sf.System.Vector2.sfVector2u;
   AktuelleFeldposition : Sf.System.Vector2.sfVector2u;
   
   procedure BasisgrundBerechnen;
   procedure ZusatzgrundBerechnen;
   procedure FlüsseBerechnen;
   procedure RohstoffeBerechnen;
   procedure VerbesserungenBerechnen;
   procedure WegeBerechnen;
   procedure FeldeffekteBerechnen;
   
   procedure Speziesberechnungen;
   procedure AllgenmeinesSpezienBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure EinheitenBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure GebäudeBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure IntroBerechnen;
   procedure OutroBerechnen;
   procedure AllgemeinesBerechnen;
   procedure Kartenbefehle;
   procedure Einheitenbefehle;
   procedure Kartenformen;
   
end TexturenfelderBerechnenGrafik;
