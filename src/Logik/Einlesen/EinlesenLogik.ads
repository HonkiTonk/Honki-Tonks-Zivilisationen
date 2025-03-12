private with Ada.Strings.Wide_Wide_Unbounded;
private with Ada.Locales;

private with BetriebssystemDatentypen;

package EinlesenLogik is
   pragma Elaborate_Body;

   procedure EinlesenOhneAnzeige;
   procedure EinlesenMitAnzeige;

private
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Locales;

   GewählteSprache : Unbounded_Wide_Wide_String;

   LokaleSprache : Ada.Locales.Language_Code;

   type SprachenRecord is record

      ISONummer : Ada.Locales.Language_Code;

      Sprache : Unbounded_Wide_Wide_String;

   end record;

   type StandardsprachenArray is array (BetriebssystemDatentypen.Standardsprachen_Enum'Range) of SprachenRecord;
   Standardsprachen : constant StandardsprachenArray := (
                                                         BetriebssystemDatentypen.Arabisch_Enum =>
                                                           (
                                                            ISONummer => "aao",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Arabic")
                                                           ),

                                                         BetriebssystemDatentypen.Chinesisch_Vereinfacht_Enum =>
                                                           (
                                                            ISONummer => "cmn",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Chinese_Simplified")
                                                           ),

                                                         BetriebssystemDatentypen.Dänisch_Enum =>
                                                           (
                                                            ISONummer => "dan",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Dansk")
                                                           ),

                                                         BetriebssystemDatentypen.Deutsch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Deutsch")
                                                           ),

                                                         BetriebssystemDatentypen.Englisch_Enum =>
                                                           (
                                                            ISONummer => "eng",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "English")
                                                           ),

                                                         BetriebssystemDatentypen.Spanisch_Enum =>
                                                           (
                                                            ISONummer => "spa",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Espanol")
                                                           ),

                                                         BetriebssystemDatentypen.Französisch_Enum =>
                                                           (
                                                            ISONummer => "fra",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Francais")
                                                           ),

                                                         BetriebssystemDatentypen.Griechisch_Enum =>
                                                           (
                                                            ISONummer => "gmy",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Greek")
                                                           ),

                                                         BetriebssystemDatentypen.Indonesisch_Enum =>
                                                           (
                                                            ISONummer => "ind",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Indonesia")
                                                           ),

                                                         BetriebssystemDatentypen.Italienisch_Enum =>
                                                           (
                                                            ISONummer => "ita",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Italiano")
                                                           ),

                                                         BetriebssystemDatentypen.Japanisch_Enum =>
                                                           (
                                                            ISONummer => "jpn",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Japanese")
                                                           ),

                                                         BetriebssystemDatentypen.Koreanisch_Enum =>
                                                           (
                                                            ISONummer => "kor",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Korean")
                                                           ),

                                                         BetriebssystemDatentypen.Niederländisch_Enum =>
                                                           (
                                                            ISONummer => "nld",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Nederlands")
                                                           ),

                                                         BetriebssystemDatentypen.Norwegisch_Enum =>
                                                           (
                                                            ISONummer => "nor",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Norsk")
                                                           ),

                                                         BetriebssystemDatentypen.Polnisch_Enum =>
                                                           (
                                                            ISONummer => "pol",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Polska")
                                                           ),

                                                         BetriebssystemDatentypen.Portugisisch_Enum =>
                                                           (
                                                            ISONummer => "por",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Portugues")
                                                           ),

                                                         BetriebssystemDatentypen.Ukrainisch_Enum =>
                                                           (
                                                            ISONummer => "ukr",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Ukrainian")
                                                           ));



   function Systemsprache
     return Unbounded_Wide_Wide_String;

end EinlesenLogik;
