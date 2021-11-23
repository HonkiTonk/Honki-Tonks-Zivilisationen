pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with GlobaleTexte;

package TextAnzeigeSFML is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive);
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive);
   
private
            
   LängsterText : Positive;
   
   ÜberschriftAbstand : Natural;
   AktuelleZeile : Natural;
   TextAnfang : Positive;
   TextEnde : Positive;
   
   StartPositionYAchse : constant Float := 20.00;
   ZeilenAbstand : Float;
   
   AktuelleTextFarbe : Sf.Graphics.Color.sfColor;
            
   TextAccess : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
      
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuelleZeileExtern : in Positive);
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr);
   
   procedure TextSetzen
     (TextExtern : in Wide_Wide_String;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr);
   
   
      
   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float;
   
   function ZeilenPositionErmitteln
     return Float;

end TextAnzeigeSFML;
