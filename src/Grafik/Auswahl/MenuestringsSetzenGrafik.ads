with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with MenueDatentypen;
with MenueKonstanten;

private with UmwandlungenAdaEigenes;

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
   
   ZeileAuflösungÄndern : constant Positive := 2;
   ZeileVollbildUmschalten : constant Positive := 3;
   ZeileBildrateÄndern : constant Positive := 4;
   ZeileEbeneUnterhalbAnzeigen : constant Positive := 5;
   ZeileBildrateAnzeigen : constant Positive := 6;
   
   ZeileSoundlautstärke : constant Positive := 2;
   ZeileMusiklautstärke : constant Positive := 3;
   
   ZeileAutomatischeSpielstände : constant Positive := 2;
   ZeileRundenBisAutospeichern : constant Positive := 3;
   
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
   
   function Spieleinstellungen
     (WelcheZeileExtern : in Positive)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 WelcheZeileExtern <= MenueKonstanten.EndeMenü (MenueDatentypen.Spieleinstellungen_Menü_Enum)
              );
   
   function ZahlAlsString is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => Natural);

end MenuestringsSetzenGrafik;
