private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with MenueDatentypen;
with MenueKonstanten;

private with UmwandlungssystemHTSEB;

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
   use Ada.Strings.Wide_Wide_Unbounded;
   
   ZeileAuflösungÄndern : constant Positive := 2;
   ZeileVollbildUmschalten : constant Positive := ZeileAuflösungÄndern + 1;
   ZeileVSync : constant Positive := ZeileVollbildUmschalten + 1;
   ZeileBildrateÄndern : constant Positive := ZeileVSync + 1;
   ZeileEbeneUnterhalbAnzeigen : constant Positive := ZeileBildrateÄndern + 1;
   ZeileBildrateAnzeigen : constant Positive := ZeileEbeneUnterhalbAnzeigen + 1;
   
   ZeileSoundlautstärke : constant Positive := 2;
   ZeileMusiklautstärke : constant Positive := ZeileSoundlautstärke + 1;
   
   ZeileAutomatischeSpielstände : constant Positive := 2;
   ZeileRundenBisAutospeichern : constant Positive := ZeileAutomatischeSpielstände + 1;
   
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
   
   function ZahlAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => Natural);

end MenuestringsSetzenGrafik;
