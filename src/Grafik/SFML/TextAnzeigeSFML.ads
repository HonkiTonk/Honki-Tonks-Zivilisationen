pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

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
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum);
   
private
   
   RahmenGezeichnet : Boolean;
         
   LängsterText : Positive;
   
   ÜberschriftAbstand : Natural;
   AktuelleZeile : Natural;
   
   Zeilenabstand : constant Float := 12.00;
   Rahmenabstand : constant Float := 6.00;
   Rahmendicke : constant Float := 3.00;
   
   RahmenlängeBerechnen : Float;
   Rahmenlänge : Float;
   Rahmenhöhe : Float;
   Position : Float;
      
   TextZugriff : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   StartAnzeigePosition : constant Sf.System.Vector2.sfVector2f := (x => 20.00,
                                                                    y => 20.00);
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      AktuelleZeileExtern : in Natural);
   
   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextZugriffExtern : in Sf.Graphics.sfText_Ptr);
   
   procedure TextSetzen
     (TextExtern : in Wide_Wide_String;
      TextZugriffExtern : in Sf.Graphics.sfText_Ptr);
   
   
   
   function RahmenlängeErmitteln
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum)
      return Float;
   
   function RahmenhöheErmitteln
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum)
      return Float;
   
   function YPositionBestimmen
     return Float;
   
   function TextBreiteErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;
   
   function TextMittelPositionErmitteln
     (TextZugriffExtern : in Sf.Graphics.sfText_Ptr)
      return Float;

end TextAnzeigeSFML;
