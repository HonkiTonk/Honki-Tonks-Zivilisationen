with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Locales; use Ada.Locales;

with SystemDatentypen;

package EinlesenLogik is
   pragma Elaborate_Body;

   procedure EinlesenOhneAnzeige;
   procedure EinlesenMitAnzeige;

private

   GewählteSprache : Unbounded_Wide_Wide_String;

   LokaleSprache : Ada.Locales.Language_Code;

   type SprachenRecord is record

      ISONummer : Ada.Locales.Language_Code;

      Sprache : Unbounded_Wide_Wide_String;

   end record;

   type StandardsprachenArray is array (SystemDatentypen.Standardsprachen_Enum'Range) of SprachenRecord;
   Standardsprachen : constant StandardsprachenArray := (
                                                         SystemDatentypen.Arabisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Arabic")
                                                           ),

                                                         SystemDatentypen.Chinesisch_Vereinfacht_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Chinese_Simplified")
                                                           ),

                                                         SystemDatentypen.Dänisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Dansk")
                                                           ),

                                                         SystemDatentypen.Deutsch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Deutsch")
                                                           ),

                                                         SystemDatentypen.Englisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "English")
                                                           ),

                                                         SystemDatentypen.Spanisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Espanol")
                                                           ),

                                                         SystemDatentypen.Französisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Francais")
                                                           ),

                                                         SystemDatentypen.Griechisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Greek")
                                                           ),

                                                         SystemDatentypen.Indonesisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Indonesia")
                                                           ),

                                                         SystemDatentypen.Italienisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Italiano")
                                                           ),

                                                         SystemDatentypen.Japanisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Japanese")
                                                           ),

                                                         SystemDatentypen.Koreanisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Korean")
                                                           ),

                                                         SystemDatentypen.Niederländisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Nederlands")
                                                           ),

                                                         SystemDatentypen.Norwegisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Norsk")
                                                           ),

                                                         SystemDatentypen.Polnisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Polska")
                                                           ),

                                                         SystemDatentypen.Portugisisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Portugues")
                                                           ),

                                                         SystemDatentypen.Ukrainisch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Ukrainian")
                                                           ));



   function Systemsprache
     return Boolean;

end EinlesenLogik;
