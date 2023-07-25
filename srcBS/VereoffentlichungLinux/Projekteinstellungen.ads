with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : constant SystemRecords.DebugRecord := (
                                                  VolleInformation => False,
                                                  FehlerWarnung    => False,
                                                  LinuxWindows     => True,
                                                  NormalerText     => True
                                                 );

end Projekteinstellungen;
