with Sf.System.Vector2;

private with SpeziesDatentypen;

package TexturenfelderBerechnenGrafik is
   pragma Elaborate_Body;

   procedure TexturenfelderBerechnen;
   
private
   
   FelderanzahlBasisgrund : constant Sf.System.Vector2.sfVector2u := (10, 6);
   FelderanzahlZusatzgrund : constant Sf.System.Vector2.sfVector2u := (10, 8);
   FelderanzahlFlüsse : constant Sf.System.Vector2.sfVector2u := (10, 5);
   FelderanzahlRessourcen : constant Sf.System.Vector2.sfVector2u := (3, 3);
   FelderanzahlVerbesserungen : constant Sf.System.Vector2.sfVector2u := (3, 3);
   FelderanzahlWege : constant Sf.System.Vector2.sfVector2u := (7, 7);
   FelderanzahlFeldeffekte : constant Sf.System.Vector2.sfVector2u := (3, 3);
   
   FelderanzahlHintergründe : constant Sf.System.Vector2.sfVector2u := (2, 2);
   FelderanzahlEinheiten : constant Sf.System.Vector2.sfVector2u := (10, 5);
   FelderanzahlGebäude : constant Sf.System.Vector2.sfVector2u := (6, 5);
   
   FelderanzahlIntro : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlAllgemeines : constant Sf.System.Vector2.sfVector2u := (2, 2);
   FelderanzahlKartenbefehle : constant Sf.System.Vector2.sfVector2u := (3, 4);
   FelderanzahlEinheitenbefehle : constant Sf.System.Vector2.sfVector2u := (3, 5);
   FelderanzahlKartenformen : constant Sf.System.Vector2.sfVector2u := (4, 5);
   
   
   
   FelderanzahlRoterKnopf : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlSeitenleiste : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlMenüs : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlPZBEnde : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlAuswahl : constant Sf.System.Vector2.sfVector2u := (1, 1);
   FelderanzahlMeldung : constant Sf.System.Vector2.sfVector2u := (1, 1);
   
   Feldgröße : Sf.System.Vector2.sfVector2u;
   Texturengröße : Sf.System.Vector2.sfVector2u;
   AktuelleFeldposition : Sf.System.Vector2.sfVector2u;
   
   procedure BasisgrundBerechnen;
   procedure ZusatzgrundBerechnen;
   procedure FlüsseBerechnen;
   procedure RessourcenBerechnen;
   procedure VerbesserungenBerechnen;
   procedure WegeBerechnen;
   procedure FeldeffekteBerechnen;
   
   procedure Speziesberechnungen;
   procedure HintergründeBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure EinheitenBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure GebäudeBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   procedure IntroBerechnen;
   procedure AllgemeinesBerechnen;
   procedure Kartenbefehle;
   procedure Einheitenbefehle;
   procedure Kartenformen;
   
end TexturenfelderBerechnenGrafik;
