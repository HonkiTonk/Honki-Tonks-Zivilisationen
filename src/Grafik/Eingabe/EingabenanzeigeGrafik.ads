with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

with ZahlenDatentypen;
with GrafikDatentypen;
with StadtRecords;
with SpeziesDatentypen;
with SpeziesKonstanten;
with EinheitenRecords;
with EinheitenGrafikRecords;

with LeseSpeziesbelegung;

private with GrafikRecordKonstanten;

private with UmwandlungenAdaNachEigenes;

package EingabenanzeigeGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in GrafikDatentypen.Eingaben_Fragen_Enum);
   
   procedure AnzeigeEinheitenStadt
     (SpeziesStadtnameExtern : in EinheitenGrafikRecords.SpeziesStadtnameGrafikRecord;
      WelcheAuswahlExtern : in EinheitenRecords.AuswahlRecord;
      AktuelleAuswahlExtern : in Integer)
     with
       Pre => (
                 if SpeziesStadtnameExtern.Spezies /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesStadtnameExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   AktuelleAuswahl : Integer;
   
   Textbreite : Float;
   MaximaleTextbreite : Float;
   Test : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;
   
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
   
   Anzeigebereich : Sf.Graphics.Rect.sfFloatRect;
   Textbox : Sf.Graphics.Rect.sfFloatRect;

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   procedure AnzeigeJaNein;
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end EingabenanzeigeGrafik;
