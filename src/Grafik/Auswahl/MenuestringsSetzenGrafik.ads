with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with MenueDatentypen;
with MenueKonstanten;

private with UmwandlungenAdaNachEigenes;

package MenuestringsSetzenGrafik is
   pragma Elaborate_Body;

   function MenüstringsSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String
     with
       Pre => (
                 WelcheZeileExtern <= MenueKonstanten.EndeMenü (WelchesMenüExtern)
              );
   
private
   
   AktuellerText : Unbounded_Wide_Wide_String;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;
   
   
   
   function Grafikmenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 WelcheZeileExtern <= MenueKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)
              );
   
   function Soundmenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 WelcheZeileExtern <= MenueKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)
              );
   
   function SonstigesMenü
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 WelcheZeileExtern <= MenueKonstanten.EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum)
              );
   
   function ZahlAlsString is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end MenuestringsSetzenGrafik;
