private with Sf.System.Vector2;

with GrafikDatentypen;
with MenueDatentypen;

private with GrafikRecordKonstanten;

package AllgemeineViewsGrafik is
   pragma Elaborate_Body;
   
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Gesamtanzeige_Enum;
      SpielenamenExtern : in Boolean);
   
   procedure ÜberschriftErmitteln
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      ZeileExtern : in Positive);
   
   procedure Versionsnummer
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Anzeige_Enum);
   
private
   
   type Flächen_Enum is (Überschrift_Enum, Versionsnummer_Enum);
   
   Textbreite : Float;
   
   type ViewflächenArray is array (Flächen_Enum'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartView);
   
   Textposition : Sf.System.Vector2.sfVector2f;

end AllgemeineViewsGrafik;
