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
                                            
      return NameEingeben (FrageExtern => Frage);
      
   end StadtName;
   
   
   
   function SpielstandName
     return SystemRecordsHTSEB.TextEingabeRecord
   is begin
      
      Name := NameEingeben (FrageExtern => TextnummernKonstanten.FrageSpielstandname);
      
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
     (FrageExtern : in Positive)
      return SystemRecordsHTSEB.TextEingabeRecord
   is begin
            
      case
        FrageExtern
      is
         when TextnummernKonstanten.FrageStadtname =>
            null;
            
         when others =>
            SchreibeLogiktask.KompletteTexteingabe (EingabeExtern => SystemRecordsKonstantenHTSEB.LeerTexteingabe);
      end case;
      
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => FrageExtern);
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Text_Eingabe_Enum);
      
      SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
      SchreibeGrafiktask.Texteingabe (JaNeinExtern        => True,
                                      ZeichenanzahlExtern => 0);
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
      return LeseLogiktask.KompletteTexteingabe;
      
   end NameEingeben;
   
   
   
   function ZeichenEingeben
     (FrageExtern : in Positive)
      return SystemRecordsHTSEB.ZeichenEingabeRecord
   is begin
      
      SchreibeLogiktask.KompletteTexteingabe (EingabeExtern => SystemRecordsKonstantenHTSEB.LeerTexteingabe);
      
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => FrageExtern);
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Text_Eingabe_Enum);
      
      SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
      SchreibeGrafiktask.Texteingabe (JaNeinExtern        => True,
                                      ZeichenanzahlExtern => 1);
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
      return (LeseLogiktask.ErfolgTexteingabe, To_Wide_Wide_String (Source => LeseLogiktask.Texteingabe) (1));
      
   end ZeichenEingeben;

end TexteingabeLogik;
