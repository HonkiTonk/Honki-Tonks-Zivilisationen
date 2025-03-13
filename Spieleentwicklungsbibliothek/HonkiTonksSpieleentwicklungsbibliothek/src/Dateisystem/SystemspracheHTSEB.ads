with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Locales;

private with BetriebssystemDatentypenHTSEB;

package SystemspracheHTSEB is
   pragma Elaborate_Body;
   
   function Systemsprache
     return Unbounded_Wide_Wide_String;
   
private

   LokaleSprache : Ada.Locales.Language_Code;

   type SprachenRecord is record

      ISONummer : Ada.Locales.Language_Code;

      Sprache : Unbounded_Wide_Wide_String;

   end record;

   type StandardsprachenArray is array (BetriebssystemDatentypenHTSEB.Standardsprachen_Enum'Range) of SprachenRecord;
   Standardsprachen : constant StandardsprachenArray := (
                                                         BetriebssystemDatentypenHTSEB.Arabisch_Enum =>
                                                           (
                                                            ISONummer => "aao",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Arabic")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Chinesisch_Vereinfacht_Enum =>
                                                           (
                                                            ISONummer => "cmn",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Chinese_Simplified")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Dänisch_Enum =>
                                                           (
                                                            ISONummer => "dan",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Dansk")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Deutsch_Enum =>
                                                           (
                                                            ISONummer => "deu",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Deutsch")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Englisch_Enum =>
                                                           (
                                                            ISONummer => "eng",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "English")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Spanisch_Enum =>
                                                           (
                                                            ISONummer => "spa",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Espanol")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Französisch_Enum =>
                                                           (
                                                            ISONummer => "fra",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Francais")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Griechisch_Enum =>
                                                           (
                                                            ISONummer => "gmy",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Greek")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Indonesisch_Enum =>
                                                           (
                                                            ISONummer => "ind",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Indonesia")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Italienisch_Enum =>
                                                           (
                                                            ISONummer => "ita",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Italiano")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Japanisch_Enum =>
                                                           (
                                                            ISONummer => "jpn",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Japanese")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Koreanisch_Enum =>
                                                           (
                                                            ISONummer => "kor",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Korean")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Niederländisch_Enum =>
                                                           (
                                                            ISONummer => "nld",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Nederlands")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Norwegisch_Enum =>
                                                           (
                                                            ISONummer => "nor",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Norsk")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Polnisch_Enum =>
                                                           (
                                                            ISONummer => "pol",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Polska")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Portugisisch_Enum =>
                                                           (
                                                            ISONummer => "por",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Portugues")
                                                           ),

                                                         BetriebssystemDatentypenHTSEB.Ukrainisch_Enum =>
                                                           (
                                                            ISONummer => "ukr",
                                                            Sprache   => To_Unbounded_Wide_Wide_String (Source => "Ukrainian")
                                                           ));
   
   
   
   function Existenzprüfung
     (OrdnernameExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 To_Wide_Wide_String (Source => OrdnernameExtern)'Length > 0
              );

end SystemspracheHTSEB;
