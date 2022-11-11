with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with MenueDatentypen;

package MenuestringsSetzenGrafik is
   pragma Elaborate_Body;

   function MenüstringsSetzen
     (WelcheZeileExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return Wide_Wide_String;
   
private
   
   AktuellerText : Unbounded_Wide_Wide_String;

end MenuestringsSetzenGrafik;
