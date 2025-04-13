with TaskRecords;

package Logiktask is
   pragma Elaborate_Body;
   
   Warten : TaskRecords.WartenLogikRecord := (others => True);
   
   Eingabe : TaskRecords.EingabeLogikRecord;
   
   Scrollleiste : Boolean := True;
      
end Logiktask;
