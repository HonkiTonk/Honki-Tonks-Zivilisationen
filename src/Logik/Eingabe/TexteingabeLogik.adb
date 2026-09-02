with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecordsKonstantenHTSEB;
with TextKonstantenHTSEB;

with TextnummernKonstanten;
with Speziestexte;
with GrafikDatentypen;

with LeseStadtGebaut;
with SchreibeLogiktask;
with LeseLogiktask;
with SchreibeGrafiktask;

with EingabeAllgemeinLogik;

package body TexteingabeLogik is

   function StadtName
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauenExtern : in Boolean)
      return SystemRecordsHTSEB.TextEingabeRecord
   is begin
      
      if
        BauenExtern
      then
         Frage := TextnummernKonstanten.FrageStadtname;
         SchreibeLogiktask.Texteingabe (TextExtern => Speziestexte.Städtenamen (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer));
         
      elsif
        StadtSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
      then
         Frage := TextnummernKonstanten.FrageStadtSuchen;
         SchreibeLogiktask.Texteingabe (TextExtern => TextKonstantenHTSEB.LeerUnboundedString);
         
      else
         Frage := TextnummernKonstanten.FrageStadtname;
         SchreibeLogiktask.Texteingabe (TextExtern => LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      end if;
                                            
      return NameEingeben (WelcheFrageExtern => Frage);
      
   end StadtName;
   
   
   
   function SpielstandName
     return SystemRecordsHTSEB.TextEingabeRecord
   is begin
      
      Name := NameEingeben (WelcheFrageExtern => TextnummernKonstanten.FrageSpielstandname);
      
      case
        Name.ErfolgreichAbbruch
      is
         when False =>
            return Name;
            
         when True =>
            null;
      end case;

      case
        To_Wide_Wide_String (Source => Name.EingegebenerText)'Length
      is
         when 0 =>
            return (True, TextKonstantenHTSEB.LeerzeichenUnboundedString);
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecordsHTSEB.TextEingabeRecord
   is begin
            
      case
        WelcheFrageExtern
      is
         when TextnummernKonstanten.FrageStadtname =>
            null;
            
         when others =>
            SchreibeLogiktask.KompletteTexteingabe (EingabeExtern => SystemRecordsKonstantenHTSEB.LeerTexteingabe);
      end case;
      
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => WelcheFrageExtern);
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Text_Eingabe_Enum);
      
      SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
      SchreibeGrafiktask.Texteingabe (JaNeinExtern => True);
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
      return LeseLogiktask.KompletteTexteingabe;
      
   end NameEingeben;
   
   -- Texteingabe mit Begrenzung auf ein Zeichen einbauen, dann kann ich theoretisch alls Zeichen erlauben und nicht nur die die die SFML zulässt? äöü

end TexteingabeLogik;
