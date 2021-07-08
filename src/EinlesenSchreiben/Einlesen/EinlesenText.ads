pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleTexte;

package EinlesenText is
   
   function EinlesenTextNeu
     return Boolean;
   
private
   
   LeereZeilenAbzieher : Natural;
   
   type WelcheTexteEinlesenNeuArray is array (GlobaleTexte.TexteEinlesenNeuArray'Range (1)) of Unbounded_Wide_Wide_String;
   WelcheTexteEinlesenNeu : WelcheTexteEinlesenNeuArray;

   DateiNeuWelcheTexteEinlesen : File_Type;
   DateiNeuText : File_Type;

end EinlesenText;
