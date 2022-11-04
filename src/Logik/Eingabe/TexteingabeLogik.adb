pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextnummernKonstanten;
with Rassentexte;
with SystemRecordKonstanten;
with GrafikDatentypen;
with TextKonstanten;

with NachLogiktask;
with NachGrafiktask;
with EingabeAllgemeinLogik;

package body TexteingabeLogik is

   function StadtName
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return SystemRecords.TextEingabeRecord
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            Frage := TextnummernKonstanten.FrageStadtSuchen;
            NachLogiktask.EingegebenerText.EingegebenerText := TextKonstanten.LeerUnboundedString;
            
         when others =>
            Frage := TextnummernKonstanten.FrageStadtname;
            NachLogiktask.EingegebenerText.EingegebenerText := Rassentexte.Städtenamen (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer);
      end case;
      
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
            return (True, To_Unbounded_Wide_Wide_String (Source => "Kein Name"));
              
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
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TextEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      
      return NachLogiktask.EingegebenerText;
      
   end NameEingeben;

end TexteingabeLogik;
