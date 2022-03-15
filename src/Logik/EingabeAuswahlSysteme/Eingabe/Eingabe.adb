pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;

with EingabeKonsole;
with EingabeSFML;
with Fehler;

package body Eingabe is

   function GanzeZahl
     (ZeileExtern : in Positive;
      ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return SystemRecords.ZahlenEingabeRecord
   is begin
      
      -- TextDateiExtern später auch in Konsole entfernen. Und alle Fragen nach Fragen verschieben, sonst funktioniert das hier nicht so richtig. Ist auch sinnvollder aufgeteilt dann.
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return EingabeKonsole.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                             ZahlenMaximumExtern => ZahlenMaximumExtern,
                                             WelcheFrageExtern   => ZeileExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            return EingabeSFML.GanzeZahl (ZahlenMinimumExtern => ZahlenMinimumExtern,
                                          ZahlenMaximumExtern => ZahlenMaximumExtern,
                                          WelcheFrageExtern   => ZeileExtern);
      end case;
      
   end GanzeZahl;

   

   function StadtName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return EingabeKonsole.StadtName;
            
         when SystemDatentypen.Grafik_SFML =>
            return EingabeSFML.StadtName;
      end case;
      
   end StadtName;



   function SpielstandName
     return SystemRecords.TextEingabeRecord
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return EingabeKonsole.SpielstandName;
            
         when SystemDatentypen.Grafik_SFML =>
            return EingabeSFML.SpielstandName;
      end case;
      
   end SpielstandName;



   procedure WartenEingabe
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            EingabeKonsole.WartenEingabe;
            
         when SystemDatentypen.Grafik_SFML =>
            Fehler.LogikFehler (FehlermeldungExtern => "Eingabe.WartenEingabe - Nur bei Konsole so nötig.");
      end case;
      
   end WartenEingabe;
   
   
   
   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return EingabeKonsole.Tastenwert;
            
         when SystemDatentypen.Grafik_SFML =>
            return EingabeSFML.Tastenwert;
      end case;
      
   end Tastenwert;
   
   
   
   procedure StandardTastenbelegungLaden
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            EingabeKonsole.StandardTastenbelegungLaden;
            
         when SystemDatentypen.Grafik_SFML =>
            EingabeSFML.StandardTastenbelegungLaden;
      end case;
      
   end StandardTastenbelegungLaden;

end Eingabe;
