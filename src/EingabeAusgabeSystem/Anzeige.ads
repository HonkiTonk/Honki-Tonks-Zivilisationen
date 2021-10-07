pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with GlobaleTexte; use GlobaleTexte;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;

package Anzeige is
   
   type AllgemeineAnzeigeTextRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;
   
   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type AlgemeineAnzeigeTextArray is array (EinheitStadtDatentypen.MinimimMaximumID'First + 2 .. EinheitStadtDatentypen.MinimimMaximumID'Last) of AllgemeineAnzeigeTextRecord;
   AllgemeineAnzeigeText : AlgemeineAnzeigeTextArray;
   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
          and
            (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);

   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive);

   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
          and
            (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);

   procedure AnzeigeSprache
     (AktuelleAuswahlExtern : in Positive;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive)
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern);

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
     with
       Pre =>
         ((if ÜberschriftDateiExtern = GlobaleTexte.Leer then ÜberschriftZeileExtern = 0)
          and
            (if ÜberschriftZeileExtern = 0 then ÜberschriftDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitStadtDatentypen.MinimimMaximumID);
   
   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum);

private
   
   RahmenGezeichnet : Boolean;
   
   Zeichengrenze : constant Positive := 100;
   ZeichengrenzenMultiplikator : Positive;
      
   LängsterText : Natural;
   ÜberschriftAbstand : Natural;
   AktuelleZeile : Natural;
   
   Zeilenabstand : constant Float := 8.00;
   Rahmenabstand : constant Float := 5.00;
   Rahmendicke : constant Float := 3.00;
   Rahmenlänge : Float;
   Rahmenbreite : Float;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   StartAnzeigePosition : constant Sf.System.Vector2.sfVector2f := (x => 20.00,
                                                                    y => 20.00);
   
   TextNeu : Unbounded_Wide_Wide_String;
   
   Rechteck : Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   procedure GrafischeAnzeigeAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural);
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural;
      AktuelleZeileExtern : in Natural);
   
end Anzeige;
