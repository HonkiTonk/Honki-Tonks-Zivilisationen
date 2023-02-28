with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextnummernKonstanten;
with Speziestexte;
with SystemRecordKonstanten;
with GrafikDatentypen;
with TextKonstanten;

with LeseStadtGebaut;

with NachLogiktask;
with NachGrafiktask;
with EingabeAllgemeinLogik;

package body TexteingabeLogik is

   function StadtName
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauenExtern : in Boolean)
      return SystemRecords.TextEingabeRecord
   is begin
      
      if
        BauenExtern
      then
         Frage := TextnummernKonstanten.FrageStadtname;
         NachLogiktask.EingegebenerText.EingegebenerText := Speziestexte.Städtenamen (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer);
         
      elsif
        StadtSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
      then
         Frage := TextnummernKonstanten.FrageStadtSuchen;
         NachLogiktask.EingegebenerText.EingegebenerText := TextKonstanten.LeerUnboundedString;
         
      else
         Frage := TextnummernKonstanten.FrageStadtname;
         NachLogiktask.EingegebenerText.EingegebenerText := LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end if;
      
      return NameEingeben (WelcheFrageExtern => Frage);
      
   end StadtName;
   
   
   
   function SpielstandName
     return SystemRecords.TextEingabeRecord
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
            return (True, TextKonstanten.LeerzeichenUnboundedString);
              
         when others =>
            return Name;
      end case;
      
   end SpielstandName;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord
   is begin
      
      NachGrafiktask.AnzeigeFrage := WelcheFrageExtern;
      
      case
        WelcheFrageExtern
      is
         when TextnummernKonstanten.FrageStadtname =>
            null;
            
         when others =>
            NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
      end case;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Text_Eingabe_Enum;
      
      NachLogiktask.GrafikWarten := True;
      NachGrafiktask.TextEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      
      return NachLogiktask.EingegebenerText;
      
   end NameEingeben;

end TexteingabeLogik;
