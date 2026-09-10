with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package TextaufteilungGrafik is
   pragma Elaborate_Body;

   function Wortsuche
     (AnfangExtern : in Wide_Wide_Character;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Post => (
                  Wortsuche'Result'Length <= TextExtern'Length
               );
   
private
   
   Textposition : Natural;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   
   
   function Anfangssuche
     (AnfangExtern : in Wide_Wide_Character;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Post => (
                  Anfangssuche'Result'Length <= TextExtern'Length
               );
   
   function Aufteilung
     (AnfangspositionExtern : in Positive;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
     with
       Pre => (
                 AnfangspositionExtern <= TextExtern'Last
              ),
         
       Post => (
                  Aufteilung'Result'Length <= TextExtern'Length
               );

end TextaufteilungGrafik;
