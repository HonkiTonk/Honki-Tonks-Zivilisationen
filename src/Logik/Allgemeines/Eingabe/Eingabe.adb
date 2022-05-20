pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with OptionenVariablen;

with EingabeKonsole;
with EingabeSFML;
with Fehler;

package body Eingabe is

   function GanzeZahl
     (ZeileExtern : in Positive;
      ZahlenMinimumExtern : in ZahlenDatentypen.EigenerInteger;
      ZahlenMaximumExtern : in ZahlenDatentypen.EigenerInteger)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      -- TextDateiExtern später auch in Konsole entfernen. Und alle Fragen nach Fragen verschieben, sonst funktioniert das hier nicht so richtig. Ist auch sinnvollder aufgeteilt dann.
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                                             WelcheFrageExtern   => ZeileExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                          ZahlenMaximumExtern => ZahlenMaximumExtern,
                                          WelcheFrageExtern   => ZeileExtern);
      end case;
      
   end GanzeZahl;

   

   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.StadtName;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.StadtName;
      end case;
      
   end StadtName;



   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.SpielstandName;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.SpielstandName;
      end case;
      
   end SpielstandName;



   procedure WartenEingabe
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            EingabeKonsole.WartenEingabe;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "Eingabe.WartenEingabe - Nur bei Konsole so nötig.");
      end case;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            return EingabeKonsole.Tastenwert;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return EingabeSFML.Tastenwert;
      end case;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            EingabeKonsole.StandardTastenbelegungLaden;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            EingabeSFML.StandardTastenbelegungLaden;
      end case;
      
   end StandardTastenbelegungLaden;

end Eingabe;
